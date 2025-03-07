extends "res://Scene/Base/enemy.gd"
@onready var attack_timer = $Timer
@onready var animated_Timer = $animatedTimer
var left_or_right: int 
@export var animated: AnimatedSprite2D
@export var damage_left: Area2D
@export var damage_right: Area2D
var is_attack: bool = false
var can_attack: bool = true

func _ready():
	super()
	attack_timer.timeout.connect(_on_timer_timeout)
	animated_Timer.timeout.connect(_on_animated_timer_timeout)
	

	attack_timer.start()
func _on_timer_timeout():
	can_attack = true
func _on_animated_timer_timeout():
	is_attack = false

func _physics_process(_delta: float) -> void:
	
	if global_position.distance_to(player.global_position) < 180:
		if can_attack:
			attack()
			can_attack = false
			is_attack = true
		else:
			damage_right.monitoring = false
			damage_left.monitoring = false
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
	
	
	if left_or_right == 2:
		damage_right.monitoring = true
		animated.play("attack_right")
		
		
			
	if left_or_right == 1:
		damage_left.monitoring = true
		animated.play("attack_left")
	animated_Timer.start()
		
