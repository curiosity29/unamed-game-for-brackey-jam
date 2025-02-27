extends CharacterBody2D
@export var move_speed: float = 50
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
var player: Player:
	get: return Instance.player

var direction: Vector2 = Vector2.ONE.normalized()
var player_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	rotation = direction.angle_to(direction)
	nav_agent.target_position = player.global_position
	player_position = player.global_position

	
func _process(delta: float) -> void:
	rotation = direction.angle_to(direction)
	
	direction = (player_position - global_position).normalized()



	

	
		
		
	
	velocity = velocity.move_toward(direction * move_speed,delta * move_speed)
	
	move_and_slide()
