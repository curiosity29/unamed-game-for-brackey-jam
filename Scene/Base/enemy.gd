


class_name Enemy
extends CharacterBody2D


var direction: Vector2 = Vector2.ZERO
@export var acceleration_mult: float = 5
# gravitation
@export var is_gravity: bool = true
@export var gravity: float = 10
@export var jump_force = 15

@onready var hitbox: Area2D = %Hitbox 
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

@export var move_speed = 50.0
var hittable_interface: HittableInterface

@export var health: int = 20
var player: Player:
	get: return Instance.player

func _ready() -> void:
	hittable_interface = HittableInterface.new(health, self)




func _process(_delta: float) -> void:
	#gravity


	
	nav_agent.target_position = player.global_position
	direction = (nav_agent.get_next_path_position() - global_position).normalized()
	
	velocity = velocity.move_toward(direction * move_speed, move_speed * acceleration_mult)
	
	move_and_slide()
	


