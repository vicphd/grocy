$path = 'data/config.php'
$content = Get-Content $path

# Disable browser barcode camera scanning
$content = $content -replace "Setting\('FEATURE_FLAG_DISABLE_BROWSER_BARCODE_CAMERA_SCANNING', false\);", "Setting('FEATURE_FLAG_DISABLE_BROWSER_BARCODE_CAMERA_SCANNING', true);"

# Disable stock barcode lookup plugin
$content = $content -replace "Setting\('STOCK_BARCODE_LOOKUP_PLUGIN', 'OpenFoodFactsBarcodeLookupPlugin'\);", "Setting('STOCK_BARCODE_LOOKUP_PLUGIN', '');"

# Set meal plan week start to Saturday (6)
# Note: The default might be empty string '', so we replace that.
$content = $content -replace "Setting\('MEAL_PLAN_FIRST_DAY_OF_WEEK', ''\);", "Setting('MEAL_PLAN_FIRST_DAY_OF_WEEK', '6');"

# Set entry page to mealplan
$content = $content -replace "Setting\('ENTRY_PAGE', 'stock'\);", "Setting('ENTRY_PAGE', 'mealplan');"

Set-Content $path $content
Write-Host "Configuration updated."
