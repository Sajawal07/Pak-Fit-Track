"""Surgically re-align a 4 KB-era ELF shared library to 16 KiB page sizes.

Google Play 16 KB requirement (both conditions per Android linker rules):
  1) every PT_LOAD p_align >= 16384
  2) congruence: (p_offset - p_vaddr) % 16384 == 0

Strategy: insert NUL padding into the FILE GAPS *before* each PT_LOAD after
the first so that p_offset becomes congruent to its p_vaddr mod 16 KiB, then
set p_align = 16 KiB.  Virtual addresses are NEVER modified, section/segment
contents are NEVER modified (asserted byte-for-byte), so relocations,
dynamic tables, symbol tables and runtime behaviour are untouched.

Verified invariants enforced before writing:
  - no section straddles an insertion point (no mid-section padding)
  - no insertion point falls strictly inside a PT_LOAD file range
  - shifted sections keep sh_offset == sh_addr (mod sh_addralign)
  - all section contents byte-identical after the transform
  - all PT_LOAD contents byte-identical after the transform
  - final: p_align >= 0x4000 and congruent for every PT_LOAD
"""
import struct
import sys

MIN = 0x4000  # 16 KiB
PT_LOAD = 1
SHT_NOBITS = 8


def parse(b, e_phoff, e_phentsize, e_phnum, e_shoff, e_shentsize, e_shnum, is64):
    def ph(i):
        o = e_phoff + i * e_phentsize
        if is64:
            p_type, p_flags = struct.unpack_from("<II", b, o)
            p_off, p_va, _pp, p_filesz, p_memsz, p_align = struct.unpack_from("<QQQQQQ", b, o + 8)
        else:
            p_type = struct.unpack_from("<I", b, o)[0]
            p_off, p_va, _pp, p_filesz, p_memsz, p_flags, p_align = struct.unpack_from("<IIIIIII", b, o + 4)
        return dict(i=i, o=o, type=p_type, off=p_off, va=p_va, filesz=p_filesz, memsz=p_memsz, align=p_align)

    def sh(i):
        o = e_shoff + i * e_shentsize
        sh_name, sh_type = struct.unpack_from("<II", b, o)
        if is64:
            _flags, sh_addr, sh_off, sh_size = struct.unpack_from("<QQQQ", b, o + 8)
            _link, _info = struct.unpack_from("<II", b, o + 40)
            sh_align, _entsize = struct.unpack_from("<QQ", b, o + 48)
        else:
            _flags, sh_addr, sh_off, sh_size, _link, _info, sh_align, _entsize = struct.unpack_from("<IIIIIIII", b, o + 8)
        return dict(i=i, o=o, name=sh_name, type=sh_type, addr=sh_addr, off=sh_off, size=sh_size, align=sh_align)

    phdrs = [ph(i) for i in range(e_phnum)]
    shdrs = [sh(i) for i in range(e_shnum)]
    return phdrs, shdrs


def convert(in_path, out_path):
    raw = open(in_path, "rb").read()
    b = bytearray(raw)
    assert bytes(b[:4]) == b"\x7fELF", f"{in_path}: not an ELF"
    cls = b[4]
    assert cls in (1, 2), f"{in_path}: bad EI_CLASS"
    is64 = cls == 2
    if is64:
        e_phoff = struct.unpack_from("<Q", b, 32)[0]
        e_shoff = struct.unpack_from("<Q", b, 40)[0]
        e_phentsize, e_phnum, e_shentsize, e_shnum = struct.unpack_from("<HHHH", b, 54)
    else:
        e_phoff = struct.unpack_from("<I", b, 28)[0]
        e_shoff = struct.unpack_from("<I", b, 32)[0]
        e_phentsize, e_phnum, e_shentsize, e_shnum = struct.unpack_from("<HHHH", b, 42)
    assert e_phnum > 0 and e_shnum > 0, f"{in_path}: empty tables"

    phdrs, shdrs = parse(b, e_phoff, e_phentsize, e_phnum, e_shoff, e_shentsize, e_shnum, is64)
    loads = [p for p in phdrs if p["type"] == PT_LOAD]
    assert loads, f"{in_path}: no PT_LOAD"
    print(f"== {in_path}")
    print(f"  {len(loads)} LOAD / {len(phdrs)} phdr / {len(shdrs)} shdr, ELF{'64' if is64 else '32'}")

    # first LOAD must already be congruent (we cannot grow it backwards)
    d0 = (loads[0]["va"] - loads[0]["off"]) % MIN
    assert d0 == 0, f"{in_path}: first LOAD diff {d0:#x} != 0 — unsupported layout"

    # decide insertions: pad before LOAD[1..] so off becomes congruent to va
    inserts = []  # (orig_pos, delta, cum_before)
    cum = 0
    for seg in loads[1:]:
        cur = seg["off"] + cum
        delta = (seg["va"] - cur) % MIN
        if delta:
            inserts.append((seg["off"], delta, cum))
            cum += delta
    if not inserts:
        print("  already 16 KiB compliant")
        open(out_path, "wb").write(raw)
        return True

    # safety: nothing may straddle an insertion point; padding stays in gaps
    for pos, delta, _ in inserts:
        for s in shdrs:
            if s["type"] == SHT_NOBITS or s["size"] == 0:
                continue
            lo, hi = s["off"], s["off"] + s["size"]
            assert not (lo < pos < hi), f"{in_path}: section #{s['i']} [{lo:#x},{hi:#x}) straddles insertion {pos:#x}"
        for p in loads:
            lo, hi = p["off"], p["off"] + p["filesz"]
            assert not (lo < pos < hi), f"{in_path}: LOAD #{p['i']} [{lo:#x},{hi:#x}) straddles insertion {pos:#x}"

    # keep sh_offset congruent with sh_addralign after the shift
    def shift_of(offv):
        return sum(d for pos, d, _ in inserts if offv >= pos)

    for s in shdrs:
        if s["align"] and s["align"] > 1:
            assert shift_of(s["off"]) % s["align"] == 0, f"{in_path}: section #{s['i']} addralign broken"

    # build padded file
    out = bytearray()
    prev = 0
    for pos, delta, _ in inserts:
        out += b[prev:pos]
        out += b"\x00" * delta
        prev = pos
    out += b[prev:]
    assert len(out) == len(raw) + cum, "size mismatch"

    # ELF header: section header table moved
    new_e_shoff = e_shoff + shift_of(e_shoff)
    if is64:
        struct.pack_into("<Q", out, 40, new_e_shoff)
    else:
        struct.pack_into("<I", out, 32, new_e_shoff)

    # program headers live before the first insertion -> edit in place
    assert e_phoff < inserts[0][0], f"{in_path}: PHDR table overlaps insertion region"
    for p in phdrs:
        new_off = p["off"] + shift_of(p["off"])
        if is64:
            if p["type"] == PT_LOAD:
                struct.pack_into("<Q", out, p["o"] + 48, MIN)  # p_align
            struct.pack_into("<Q", out, p["o"] + 8, new_off)
        else:
            if p["type"] == PT_LOAD:
                struct.pack_into("<I", out, p["o"] + 28, MIN)  # p_align
            struct.pack_into("<I", out, p["o"] + 4, new_off)

    # section headers (table itself moved)
    for s in shdrs:
        o = new_e_shoff + s["i"] * e_shentsize
        new_off = s["off"] + shift_of(s["off"])
        if is64:
            struct.pack_into("<Q", out, o + 24, new_off)
        else:
            struct.pack_into("<I", out, o + 16, new_off)

    # ---- verify everything on the produced bytes ----
    n_ph, n_sh = parse(out, e_phoff, e_phentsize, e_phnum, new_e_shoff, e_shentsize, e_shnum, is64)
    n_loads = [p for p in n_ph if p["type"] == PT_LOAD]
    assert len(n_loads) == len(loads), "LOAD count changed"

    for s in shdrs:
        if s["type"] == SHT_NOBITS or s["size"] == 0:
            continue
        old = raw[s["off"]:s["off"] + s["size"]]
        ns = n_sh[s["i"]]
        new = bytes(out[ns["off"]:ns["off"] + s["size"]])
        assert old == new, f"{in_path}: section #{s['i']} content changed"
    # LOAD #0 maps the ELF header + program header table, which we legitimately
    # rewrote (e_shoff, p_offset, p_align). Skip exactly that prefix; everything
    # else in every LOAD must be byte-identical.
    hdr_end = e_phoff + e_phnum * e_phentsize
    for i, p in enumerate(loads):
        np_ = n_loads[i]
        skip = max(0, hdr_end - p["off"])
        old = raw[p["off"] + skip:p["off"] + p["filesz"]]
        new = bytes(out[np_["off"] + skip:np_["off"] + np_["filesz"]])
        assert old == new, f"{in_path}: LOAD #{i} content changed (beyond ELF header/phdrs)"
        diff = (np_["off"] - np_["va"]) % MIN
        assert np_["align"] >= MIN, f"{in_path}: LOAD #{i} align {np_['align']:#x} < 16 KiB"
        assert diff == 0, f"{in_path}: LOAD #{i} still incongruent ({diff:#x})"
        print(f"  LOAD#{i}: off={np_['off']:#x} va={np_['va']:#x} align={np_['align']:#x} diff={diff:#x} OK")
    assert new_e_shoff + e_shnum * e_shentsize <= len(out), "SHT out of file"

    open(out_path, "wb").write(bytes(out))
    print(f"  wrote {out_path} (+{cum} bytes padding)")
    return True


if __name__ == "__main__":
    args = sys.argv[1:]
    assert len(args) % 2 == 0, "usage: pad16k.py in out [in out ...]"
    for i in range(0, len(args), 2):
        convert(args[i], args[i + 1])
    print("ALL_CONVERSIONS_OK")
