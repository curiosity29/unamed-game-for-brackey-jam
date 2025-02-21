class_name RecipeSystem
extends Object

## Explanation/Intended use:
## Before casting, there's a list of charged skill on top the player head
## After a new skill is charged, it's added to the list, then what's in the recipes merge together into another skill(s)
## 
## 
## 


## 
var inventory: Dictionary[String, int] = {}
var recipes: Dictionary[Dictionary, Dictionary]
func add_ingredient_to_inventory(ingredient: String, amount: int = 1) -> void:
	if ingredient in inventory:
		inventory[ingredient] += amount
	else:
		inventory[ingredient] = amount
	inventory = auto_combine(inventory)


## Expected inventory format:
## {"fire": 2, "water": 1, "earth": 3, "air": 1}
## Expected recipes format:
## {{"fire": 1, "water": 1}: {"steam": 1}, {"earth": 1, "air": 1}: {"dust": 2}, 
## {"fire": 2, "earth": 1}: {"lava": 1, "fire": 1}} (ingredients -> new ingredients)
## Expected result format (new inventory):
## {"steam": 1, "dust": 2, "lava": 1, "fire": 1, "earth": 2, "air": 1}
func auto_combine(inventory: Dictionary[String, int]) -> Dictionary[String, int]:

	var is_combined = false
	for recipe in recipes:
		var can_combine = true
		## check if enough ingredients for the recipe
		for item in recipe:
			if item not in inventory or inventory[item] < recipe[item]:
				can_combine = false
				break
		if can_combine:
			is_combined = true
			## remove ingredients
			inventory = subtract_counter(inventory, recipe)
			## add new ingredients
			inventory = add_counter(inventory, recipes[recipe])
	
	## return if nothing combined
	if is_combined:
		return auto_combine(inventory)
	else:
		return inventory

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
				counter_a.pop(item)
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
