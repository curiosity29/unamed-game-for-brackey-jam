class_name RecipeSystem
extends Object

signal ingredient_added(ingredient: String, amount: int)
signal ingredient_removed(ingredient: String, amount: int)
signal ingredient_combined(input_ingredients: Dictionary[String, int], output_ingredients: Dictionary[String, int])
## Explanation/Intended use:
## Before casting, there's a list of charged skill on top the player head
## After a new skill is charged, it's added to the list, then what's in the recipes merge together into another skill(s)
## 
## 
## 


## inventory is the list of current charged skill
var inventory: Dictionary[String, int] = {}
var recipes: Dictionary[Dictionary, Dictionary]

func add_ingredient_to_inventory(ingredient: String, amount: int = 1, fire_signal: bool = true) -> void:
	if ingredient in inventory:
		inventory[ingredient] += amount
	else:
		inventory[ingredient] = amount
	if fire_signal: ingredient_added.emit(ingredient, amount)
	inventory = auto_combine(inventory)
	
func subtract_ingredient_from_inventory(ingredient: String, amount: int = 1, fire_signal: bool = true) -> void:
	add_ingredient_to_inventory(ingredient, -amount, false)
	if inventory[ingredient] <=0:
		inventory.erase(ingredient)
	if fire_signal: ingredient_removed.emit(ingredient, amount)

## Expected inventory format:
## {"fire": 2, "water": 1, "earth": 3, "air": 1}
## Expected recipes format:
## {{"fire": 1, "water": 1}: {"steam": 1}, {"earth": 1, "air": 1}: {"dust": 2}, 
## {"fire": 2, "earth": 1}: {"lava": 1, "fire": 1}} (ingredients -> new ingredients)
## Expected result format (new inventory):
## {"steam": 1, "dust": 2, "lava": 1, "fire": 1, "earth": 2, "air": 1}
func auto_combine(input_inventory: Dictionary[String, int]) -> Dictionary[String, int]:

	var is_combined = false
	for recipe in recipes:
		var can_combine = true
		## check if enough ingredients for the recipe
		for item in recipe:
			if item not in input_inventory or input_inventory[item] < recipe[item]:
				can_combine = false
				break
		if can_combine:
			is_combined = true
			## remove ingredients
			input_inventory = subtract_counter(input_inventory, recipe)
			## add new ingredients
			input_inventory = add_counter(input_inventory, recipes[recipe])
			ingredient_combined.emit(recipe, recipes[recipe])
	
	## return if nothing combined
	if is_combined:
		return auto_combine(input_inventory)
	else:
		return input_inventory

func add_counter(counter_a, counter_b):
	for item in counter_b:
		if item in counter_a:
			counter_a[item] += counter_b[item]
		else:
			counter_a[item] = counter_b[item]
	return counter_a

func subtract_counter(counter_a, counter_b):
	for item in counter_b:
		if item in counter_a:
			counter_a[item] -= counter_b[item]
			if counter_a[item] <= 0:
				counter_a.erase(item)
		else:
			counter_a[item] = -counter_b[item]
	return counter_a

func get_counter(array: Array) -> Dictionary:
	var counter = {}
	for item in array:
		if item in counter:
			counter[item] += 1
		else:
			counter[item] = 1
	return counter
