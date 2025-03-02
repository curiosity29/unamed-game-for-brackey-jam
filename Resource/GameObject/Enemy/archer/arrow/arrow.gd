extends CharacterBody2D
@export var move_speed: float = 400
@export var gravity = 50
var velocity_vector: Vector2
@onready var destroyTimer =$Timer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var player: Player:
	get: return Instance.player

var direction: Vector2 = Vector2.ONE.normalized()
var player_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	destroyTimer.timeout.connect(_on_timer_timeout)  
	nav_agent.target_position = player.global_position
	player_position = player.global_position
	direction = (player_position - global_position).normalized()
	velocity_vector = direction  * move_speed
	rotation = velocity_vector.angle()
	

	
func _process(delta: float) -> void:
	velocity_vector.y += gravity * delta
	global_position += velocity_vector * delta 
	rotation = velocity_vector.angle()
	if is_on_floor():
		destroyTimer.start()
	
	move_and_slide()
func _on_timer_timeout():
	queue_free()
