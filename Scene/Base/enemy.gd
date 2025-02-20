class_name Enemy
extends CharacterBody2D


@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

@export var move_speed = 50.0
@export var acceleration_mult: float = 5
var hittable_interface: HittableInterface
@onready var hitbox: Area2D = %Hitbox

@export var health: int = 20
var player: Player:
	get: return Instance.player

func _ready() -> void:
	hittable_interface = HittableInterface.new(health, self)


func _process(_delta: float) -> void:
	nav_agent.target_position = player.global_position
	var direction: Vector2 = (nav_agent.get_next_path_position() - global_position).normalized()
	
	velocity = velocity.move_toward(direction * move_speed, move_speed * acceleration_mult)
	
	move_and_slide()
