class_name Player
extends CharacterBody2D

var health = 100
var max_health = 100
var move_speed = 500

var is_moving: bool = false

var current_skill: Callable




func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if event.is_action_pressed("right_click"):
		is_moving = true
	elif event.is_action_released("right_click"):
		is_moving = false

	if event.is_action_pressed("click"):
		cast_skill(mouse_pos)

	## pretty scuff, for fast testing
	if event.is_action_pressed("skill_1"):
		current_skill = skills[keybind_to_skill["1"]]["func"]
	elif event.is_action_pressed("skill_2"):
		current_skill = skills[keybind_to_skill["2"]]["func"]
	elif event.is_action_pressed("skill_3"):
		current_skill = skills[keybind_to_skill["3"]]["func"]
	elif event.is_action_pressed("4"):
		current_skill = skills[keybind_to_skill["4"]]["func"]
	elif event.is_action_pressed("5"):
		current_skill = skills[keybind_to_skill["5"]]["func"]


func cast_skill(cast_global_position: Vector2) -> void:
	if current_skill:
		current_skill.call(cast_global_position)
	current_skill = skill_null

## move toward the mouse position if holding right click
func _process(_delta: float) -> void:
	# global_position = move_toward(global_position, get_global_mouse_position(), delta * move_speed)
	if is_moving:
		velocity = move_speed * (get_global_mouse_position() - global_position).normalized()
		
		move_and_slide()



#region skill

## create an earth ball and shoot it in the aimed direction
func skill_earth(cast_global_position: Vector2) -> void:
	var fire_direction = (cast_global_position - global_position).normalized()
	var earth_ball: Projectile = Database.game_object_scenes["earth_ball"].instantiate()
	Instance.map.add_child(earth_ball)
	earth_ball.global_position = global_position - earth_ball.size/2
	earth_ball.fire_self(fire_direction)
	pass

## do nothing, for when no skill is selected
func skill_null(_cast_global_position: Vector2) -> void:
	pass


func skill_fire(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)

func skill_ice(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)


func skill_electric(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)

func skill_water(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)

var skills: Dictionary[String, Dictionary] = {
	"earth": {
		"name": "earth",
		"cd": 1.0,
		"func": skill_earth,
		"keybind": "1"
	},
	"fire": {
		"name": "fire",
		"cd": 1.0,
		"func": skill_fire,
		"keybind": "2"
	},
	"ice": {
		"name": "ice",
		"cd": 1.0,
		"func": skill_ice,
		"keybind": "3"
	},
	"electric": {
		"name": "electric",
		"cd": 1.0,
		"func": skill_electric,
		"keybind": "4"
	},
	"water": {
		"name": "water",
		"cd": 1.0,
		"func": skill_water,
		"keybind": "5"
	}
}

## pretty scuff, for fast testing
var keybind_to_skill: Dictionary[String, String] = {
	"1": "earth",
	"2": "fire",
	"3": "ice",
	"4": "electric",
	"5": "water"
}

#endregion
