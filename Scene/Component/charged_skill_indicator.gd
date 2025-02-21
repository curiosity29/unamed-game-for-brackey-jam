class_name ChargedSkillIndicator
extends VBoxContainer

@onready var skill_name: Label = $SkillName
@onready var skill_icon: TextureRect = $CenterContainer/SkillIcon

var skill_resource: SkillResource:
	set(value):
		skill_resource = value
		skill_icon.texture = skill_resource.icon
		skill_name.text = skill_resource.name
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
