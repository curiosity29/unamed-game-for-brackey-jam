class_name SkillIndicatorContainer
extends HBoxContainer

## UI for recipe system

@export var player: Player
var recipe_manager: RecipeSystem:
	get: return player.recipe_manager
var inventory: Dictionary[String, int]:
	get: return recipe_manager.inventory
var skill_id_to_indicator_index: Dictionary[String, int] = {}
var current_first_empty_index: int = 0
var max_skill_slots: int:
	get: return get_child_count()

func _ready() -> void:
	setup_update_connection()

	
func setup_update_connection():
	if not player.is_node_ready():
		player.ready.connect(setup_update_connection, CONNECT_ONE_SHOT)
	recipe_manager.ingredient_added.connect(add_charged_skill)
	recipe_manager.ingredient_removed.connect(remove_used_skill)
	recipe_manager.ingredient_combined.connect(combine_charged_skill)

var chargedSkillIndicator: ChargedSkillIndicator
func add_charged_skill(skill_id: String, amount: int):
	var skill_resource = player.skills_map[skill_id]
	## found duplicate, add 1 to existing charge
	if skill_id in skill_id_to_indicator_index:
		chargedSkillIndicator = get_child(skill_id_to_indicator_index[skill_id])
		chargedSkillIndicator.amount += amount
	#print("add at %d" % current_index)
	## else create new indicator if it's not full
	elif current_first_empty_index < max_skill_slots:
		skill_id_to_indicator_index[skill_id] = current_first_empty_index
		chargedSkillIndicator = get_child(current_first_empty_index)
		chargedSkillIndicator.skill_resource = skill_resource
		chargedSkillIndicator.amount = amount
		chargedSkillIndicator.modulate.a = 1
		current_first_empty_index += 1

func remove_used_skill(skill_id: String, amount: int):
	assert(skill_id in skill_id_to_indicator_index, "attempting to remove skill that player does not charged")
	var skill_resource = player.skills_map[skill_id]
	#print("remove at %d" % current_index)
	chargedSkillIndicator = get_child(skill_id_to_indicator_index[skill_resource.id])
	chargedSkillIndicator.amount -= amount
	if chargedSkillIndicator.amount <= 0: ## this should not be <0
		chargedSkillIndicator.modulate.a = 0
		current_first_empty_index -= 1
		skill_id_to_indicator_index.erase(skill_id)

func combine_charged_skill(input_skills: Dictionary[String, int], output_skills: Dictionary[String, int]) -> void:
	## NOTE: will break if size of output > size of input
	## move what's left in front, put new output to back
	var new_skill_id_to_indicator_index: Dictionary[String, int]
	## create what's left in inventory that's not new first, then the rest
	var current_first_empty_index = 0
	for skill_id in inventory:
		if skill_id in skill_id_to_indicator_index and skill_id not in output_skills:
			new_skill_id_to_indicator_index[skill_id] = current_first_empty_index
			chargedSkillIndicator = get_child(current_first_empty_index)
			chargedSkillIndicator.skill_resource = player.skills_map[skill_id]
			chargedSkillIndicator.amount = inventory[skill_id]
			current_first_empty_index += 1

	for skill_id in output_skills:
		if skill_id not in skill_id_to_indicator_index:
			new_skill_id_to_indicator_index[skill_id] = current_first_empty_index
			chargedSkillIndicator = get_child(current_first_empty_index)
			chargedSkillIndicator.skill_resource = player.skills_map[skill_id]
			chargedSkillIndicator.amount = inventory[skill_id]
			current_first_empty_index += 1
	
	## update new indexs
	skill_id_to_indicator_index = new_skill_id_to_indicator_index
	
	## hide the rest
	for child_index in range(current_first_empty_index, max_skill_slots):
		get_child(child_index).modulate.a = 0
