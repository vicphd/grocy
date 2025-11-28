$phpPath = "C:\Users\victo\AppData\Local\Microsoft\WinGet\Packages\PHP.PHP.8.3_Microsoft.Winget.Source_8wekyb3d8bbwe"
$iniFile = "$phpPath\php.ini"

if (-not (Test-Path $iniFile)) {
    Write-Host "php.ini not found, copying from development template..."
    Copy-Item "$phpPath\php.ini-development" $iniFile
}

$content = Get-Content $iniFile
$content = $content -replace ';extension=curl', 'extension=curl'
$content = $content -replace ';extension=fileinfo', 'extension=fileinfo'
$content = $content -replace ';extension=gd', 'extension=gd'
$content = $content -replace ';extension=intl', 'extension=intl'
$content = $content -replace ';extension=mbstring', 'extension=mbstring'
$content = $content -replace ';extension=openssl', 'extension=openssl'
$content = $content -replace ';extension=pdo_sqlite', 'extension=pdo_sqlite'
$content = $content -replace ';extension=sqlite3', 'extension=sqlite3'
$content = $content -replace ';extension=zip', 'extension=zip'
$content = $content -replace ';extension_dir = "ext"', 'extension_dir = "ext"'

Set-Content $iniFile $content
Write-Host "php.ini updated."
