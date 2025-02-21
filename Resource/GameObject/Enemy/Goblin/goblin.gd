extends "res://Scene/Base/enemy.gd"

@export var animated: AnimatedSprite2D

func _process(_delta: float) -> void:
	if global_position.distance_to(player.global_position) < 100:
		print("can attack")
		attack()

func attack() -> void:
	animated.play("attack_right")
    
