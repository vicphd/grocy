<?php
define('GROCY_DATAPATH', 'data');
define('GROCY_MODE', 'dev');
define('GROCY_DEFAULT_LOCALE', 'en');
define('GROCY_USER_ID', 1);
require_once 'packages/autoload.php';

use Grocy\Services\DatabaseService;

$dbService = new DatabaseService();
	'base_servings' => 1,
	'desired_servings' => 1,
	'type' => 'normal'
]);
$recipeId = $db->lastInsertId();

// 3. Add to shopping list with recipe_id
$db->insert('shopping_list', [
	'product_id' => $productId,
	'amount' => 5,
	'qu_id' => 1,
	'recipe_id' => $recipeId,
	'shopping_list_id' => 1
]);

echo "Successfully added Product $productId and Recipe $recipeId to Shopping List.";
