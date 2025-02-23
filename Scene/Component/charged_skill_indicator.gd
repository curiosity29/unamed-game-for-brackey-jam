class_name ChargedSkillIndicator
extends VBoxContainer

@onready var skill_name: Label = $SkillName
@onready var skill_icon: TextureRect = $CenterContainer/SkillIcon

var amount: int = 0:
	set(value):
		amount = value
		## update visual
		if skill_resource:
			skill_name.text = text_template % [skill_resource.name, amount]
	
var text_template = "%s\nx%d"


var skill_resource: SkillResource:
	set(value):
		skill_resource = value
		skill_icon.texture = skill_resource.icon
		skill_name.text = text_template % [skill_resource.name, amount]
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
