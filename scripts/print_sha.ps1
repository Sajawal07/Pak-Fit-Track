# print_sha.ps1 - PakFitTrack SHA Fingerprint Extractor
# Run from project root: .\scripts\print_sha.ps1

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  PakFitTrack - Firebase SHA Fingerprint Extractor  " -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Package: com.pakfittrack.app" -ForegroundColor White
Write-Host "Add fingerprints in Firebase → Android app com.pakfittrack.app" -ForegroundColor White
Write-Host ""

# 1. DEBUG SHA-1
Write-Host "1. DEBUG SHA-1 (flutter run / debug APK)" -ForegroundColor Yellow
$debugKeystore = "$env:USERPROFILE\.android\debug.keystore"
if (Test-Path $debugKeystore) {
    $output = & keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android 2>&1
    $sha1 = ($output | Where-Object { $_ -match "SHA1:" } | Select-Object -First 1) -replace '.*SHA1:\s*',''
    $sha256 = ($output | Where-Object { $_ -match "SHA256:" } | Select-Object -First 1) -replace '.*SHA256:\s*',''
    Write-Host "   SHA-1:   $sha1" -ForegroundColor Green
    Write-Host "   SHA-256: $sha256" -ForegroundColor Green
} else {
    Write-Host "   [WARN] debug.keystore not found." -ForegroundColor Red
}

Write-Host ""

# 2. UPLOAD / RELEASE SHA-1
Write-Host "2. UPLOAD/RELEASE SHA-1 (appbundle --release)" -ForegroundColor Yellow
$uploadKs = "android\upload-keystore.jks"
$keyProps = "android\key.properties"
if ((Test-Path $uploadKs) -and (Test-Path $keyProps)) {
    $props = @{}
    Get-Content $keyProps | ForEach-Object {
        if ($_ -match '^\s*([^#=]+)=(.*)$') { $props[$matches[1].Trim()] = $matches[2].Trim() }
    }
    $alias = $props['keyAlias']
    $pass = $props['storePassword']
    $output = & keytool -list -v -keystore $uploadKs -alias $alias -storepass $pass -keypass $pass 2>&1
    $sha1 = ($output | Where-Object { $_ -match "SHA1:" } | Select-Object -First 1) -replace '.*SHA1:\s*',''
    $sha256 = ($output | Where-Object { $_ -match "SHA256:" } | Select-Object -First 1) -replace '.*SHA256:\s*',''
    Write-Host "   SHA-1:   $sha1" -ForegroundColor Green
    Write-Host "   SHA-256: $sha256" -ForegroundColor Green
} else {
    Write-Host "   [INFO] upload-keystore.jks / key.properties not found" -ForegroundColor DarkYellow
}

Write-Host ""
Write-Host "3. PLAY APP SIGNING SHA-1 -- after first Play upload:" -ForegroundColor Yellow
Write-Host "   Play Console -> App signing -> App signing key certificate -> SHA-1" -ForegroundColor White
Write-Host ""
Write-Host "After adding SHA-1 in Firebase, download NEW google-services.json" -ForegroundColor Cyan
Write-Host "and replace android\app\google-services.json, then rebuild." -ForegroundColor Cyan
Write-Host ""
