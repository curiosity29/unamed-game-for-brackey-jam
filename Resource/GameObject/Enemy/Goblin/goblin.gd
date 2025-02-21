extends "res://Scene/Base/enemy.gd"

var left_or_right: int 
@export var animated: AnimatedSprite2D
@export var damage_left: Area2D
@export var damage_right: Area2D

func _physics_process(_delta: float) -> void:
	print(velocity.x)
	if global_position.distance_to(player.global_position) < 100:
		attack()
	if global_position.x > player.global_position.x:
		left_or_right = 1
		animated.play("walk_left")
		damage_left.visible = true
		damage_right.visible = false
	else:
		left_or_right = 2
		animated.play("walk_right")
		damage_left.visible = false
		damage_right.visible = true

func attack() -> void:
	if left_or_right == 1:
		animated.play("attack_right")
	if left_or_right == 2:
		animated.play("attack_left")
