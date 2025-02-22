extends "res://Scene/Base/enemy.gd"

var left_or_right: int 
@export var animated: AnimatedSprite2D
@export var damage_left: Area2D
@export var damage_right: Area2D
var is_attack: bool = false

func _physics_process(_delta: float) -> void:
	
	if global_position.distance_to(player.global_position) < 180:
		attack()
		is_attack = true
	else:
		is_attack = false
	if global_position.x > player.global_position.x:
		left_or_right = 1
		if not is_attack:
			animated.play("walk_left")
			damage_left.visible = true
			damage_right.visible = false
	else:
		left_or_right = 2
		if not is_attack:
			animated.play("walk_right")
			damage_left.visible = false
			damage_right.visible = true

func attack() -> void:
	if is_attack:
		if left_or_right == 2:
			animated.play("attack_right")
			
		if left_or_right == 1:
			animated.play("attack_left")
			
		
