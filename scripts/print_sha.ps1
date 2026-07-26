# print_sha.ps1 - PakFitTrack SHA Fingerprint Extractor
# Run from project root: .\scripts\print_sha.ps1

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  PakFitTrack - Firebase SHA Fingerprint Extractor  " -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

# 1. DEBUG SHA-1
Write-Host "1. DEBUG SHA-1 (from Android debug.keystore)" -ForegroundColor Yellow

$debugKeystore = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $debugKeystore) {
    $output = & keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android 2>&1
    $sha1Line = $output | Where-Object { $_ -match "SHA1:" } | Select-Object -First 1
    if ($sha1Line) {
        Write-Host "   $sha1Line" -ForegroundColor Green
    }
} else {
    Write-Host "   [WARN] debug.keystore not found. Run: flutter build apk --debug first." -ForegroundColor Red
}

Write-Host ""

# 2. RELEASE SHA-1
Write-Host "2. RELEASE SHA-1 (from your release keystore)" -ForegroundColor Yellow

$keystorePaths = @(
    "android\app\pakfittrack-release.jks",
    "android\app\release.jks",
    "android\app\keystore.jks",
    "android\app\key.jks"
)

$foundKeystore = $null
foreach ($p in $keystorePaths) {
    if (Test-Path $p) { $foundKeystore = $p; break }
}

if ($foundKeystore) {
    $alias = Read-Host "   Found keystore at $foundKeystore. Enter key alias"
    $output = & keytool -list -v -keystore $foundKeystore -alias $alias 2>&1
    $sha1Line = $output | Where-Object { $_ -match "SHA1:" } | Select-Object -First 1
    if ($sha1Line) {
        Write-Host "   RELEASE SHA-1: $sha1Line" -ForegroundColor Green
    }
} else {
    Write-Host "   [INFO] No release keystore found in android\app\" -ForegroundColor DarkYellow
    Write-Host "   When ready, run manually:" -ForegroundColor Gray
    Write-Host "   keytool -list -v -keystore android\app\YOUR_KEY.jks -alias YOUR_ALIAS" -ForegroundColor White
}

Write-Host ""

# 3. PLAY APP SIGNING SHA-1
Write-Host "3. PLAY APP SIGNING SHA-1 (from Google Play Console)" -ForegroundColor Yellow
Write-Host "   Cannot be extracted locally. Steps:" -ForegroundColor Gray
Write-Host "   a) Upload AAB to Play Console (Internal Testing track)" -ForegroundColor White
Write-Host "   b) Go to: Release > Setup > App Integrity > App Signing" -ForegroundColor White
Write-Host "   c) Copy the SHA-1 certificate fingerprint shown there" -ForegroundColor White
Write-Host "   d) Add it to: Firebase Console > Project Settings >" -ForegroundColor White
Write-Host "      com.pakfittrack.app > SHA certificate fingerprints" -ForegroundColor White
Write-Host ""
Write-Host "   WHY: Google re-signs your AAB with their key." -ForegroundColor DarkYellow
Write-Host "   Without this, Google Sign-In FAILS silently in production." -ForegroundColor Red
Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  Add all SHA-1s to Firebase before release!" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
