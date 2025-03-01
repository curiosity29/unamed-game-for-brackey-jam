extends "res://Scene/Base/enemy.gd"

@onready var attack_timer = $Timer
var left_or_right: int 
@export var animated: AnimatedSprite2D

var is_attack: bool = false
var can_attack: bool = true

func _ready():
	super()
	attack_timer.timeout.connect(_on_timer_timeout)
	attack_timer.start()

func _on_timer_timeout():
	can_attack = true

func _physics_process(_delta: float) -> void:
	if global_position.distance_to(player.global_position) < 800:
		if can_attack:
			attack()
			can_attack = false
			is_attack = true
		
	else:
		is_attack = false
	
	if global_position.x > player.global_position.x:
		left_or_right = 1
		if not is_attack:
			animated.play("walk_left")
	else:
		left_or_right = 2
		if not is_attack:
			animated.play("walk_right")

func attack() -> void:
	velocity = Vector2.ZERO
	
	if left_or_right == 2:
		animated.play("attack_right")
		add_child(load("res://Resource/GameObject/Enemy/archer/arrow/arrow_right.tscn").instantiate())
	elif left_or_right == 1:
		animated.play("attack_left")
		add_child(load("res://Resource/GameObject/Enemy/archer/arrow/arrow_left.tscn").instantiate())
	
