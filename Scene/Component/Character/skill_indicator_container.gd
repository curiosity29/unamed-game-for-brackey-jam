class_name SkillIndicatorContainer
extends HBoxContainer

var current_index: int = 0
var chargedSkillIndicator: ChargedSkillIndicator
func add_charged_skill(skill_resource: SkillResource):
	#print("add at %d" % current_index)
	if current_index < get_child_count():
		chargedSkillIndicator = get_child(current_index)
		chargedSkillIndicator.skill_resource = skill_resource
		chargedSkillIndicator.modulate.a = 1
		
		current_index += 1

func remove_used_skill(skill_resource: SkillResource):
	#print("remove at %d" % current_index)
	current_index -= 1
	
	chargedSkillIndicator = get_child(current_index)
	chargedSkillIndicator.modulate.a = 0
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
