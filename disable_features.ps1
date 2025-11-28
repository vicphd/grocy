$path = 'data/config.php'
$content = Get-Content $path
$content = $content -replace "Setting\('FEATURE_FLAG_CHORES', true\);", "Setting('FEATURE_FLAG_CHORES', false);"
$content = $content -replace "Setting\('FEATURE_FLAG_BATTERIES', true\);", "Setting('FEATURE_FLAG_BATTERIES', false);"
Set-Content $path $content
Write-Host "Features disabled."
