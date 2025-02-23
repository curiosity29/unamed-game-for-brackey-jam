extends "res://Scene/Base/enemy.gd"


@export var animated: AnimatedSprite2D
var reception: float = 600

func _physics_process(_delta: float) -> void:
	if global_position.distance_to(player.global_position) < 600:
		attack()
	
func attack() -> void:
	pass
	
