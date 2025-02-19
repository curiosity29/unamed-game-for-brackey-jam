extends Camera2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

@export var move_speed = 50.0



var player



func _ready():
	
	player = get_node("/root/Map/Player")
	
	pass

func _process(delta: float) -> void:
	if player:
		
		global_position = lerp(global_position, player.global_position, 0.1)

		var direction: Vector2 = (player.global_position - global_position).normalized()
		position += Vector2(direction.x, 0) * move_speed * delta
