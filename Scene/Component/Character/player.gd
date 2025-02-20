class_name Player
extends CharacterBody2D

var move_speed: float = 800
var acceleration_mult: float = 10.
var friction_mult: float = 5.
var jump_velocity: int = -2000
var is_moving: bool = false
var gravity_mult: float = 10.
var current_skill: Callable


var hittable_interface: HittableInterface
var direction: Vector2

var anim_sprite: AnimatedSprite2D
@export var health: int = 100

func _ready() -> void:
	Instance.player = self
	anim_sprite = $AnimatedSprite2D
	
	hittable_interface = HittableInterface.new(health, self)

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if event.is_action_pressed("right_click"):
		is_moving = true

	elif event.is_action_released("right_click"):
		is_moving = false

	


	if event.is_action_pressed("click"):
		cast_skill(mouse_pos)
		
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity

	## pretty scuff, for fast testing

	if Input.is_action_just_pressed("skill_1") and Input.is_action_pressed("q"):
		

		#print("creat earth platform") for the test 
		current_skill = skills[keybind_to_skill["9"]]["func"]

	elif event.is_action_pressed("skill_1") :
		
		current_skill = skills[keybind_to_skill["1"]]["func"]
	elif event.is_action_pressed("skill_2"):
		current_skill = skills[keybind_to_skill["2"]]["func"]
	elif event.is_action_pressed("skill_3"):

		current_skill = skills[keybind_to_skill["3"]]["func"]
	elif event.is_action_pressed("skill_4"):
		current_skill = skills[keybind_to_skill["4"]]["func"]
	#elif event.is_action_pressed("5"):
		#current_skill = skills[keybind_to_skill["5"]]["func"]
	elif event.is_action_pressed("skill_6"):
		current_skill = skills[keybind_to_skill["6"]]["func"]
	#elif event.is_action_pressed("7"):
		#current_skill = skills[keybind_to_skill["7"]]["func"]
	#elif event.is_action_pressed("7"):
		#current_skill = skills[keybind_to_skill["8"]]["func"]




func cast_skill(cast_global_position: Vector2) -> void:
	if current_skill:
		current_skill.call(cast_global_position)
	current_skill = skill_null

## move toward the mouse position if holding right click
func _physics_process(delta: float) -> void:
	# global_position = move_toward(global_position, get_global_mouse_position(), delta * move_speed)
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_mult
		
	var direction_value = Input.get_axis("left", "right")
	if direction_value < 0:
		anim_sprite.flip_h = true
	elif direction_value > 0:
		anim_sprite.flip_h = false
		
	if direction_value:
		#var direction = Vector2.LEFT * direction_value
		velocity.x = move_toward(velocity.x, move_speed * sign(direction_value), move_speed * delta * acceleration_mult)
		
	else:
		var brake = move_speed * delta * friction_mult
		velocity.x = move_toward(velocity.x, 0, brake)
	#if is_moving:
		#direction = (get_global_mouse_position() - global_position).normalized()
		#velocity = direction * move_speed
	move_and_slide()
	update_animation(direction)

	



func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		anim_sprite.play("idle_down")
	else:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim_sprite.play("walk_right")
			else:
				anim_sprite.play("walk_left")
		else:
			if direction.y > 0:
				anim_sprite.play("walk_down")
			else:
				anim_sprite.play("walk_up")	
	#await get_tree().create_timer(0.3).timeout

	
#region skill

## create an earth ball and shoot it in the aimed direction
func skill_earth(cast_global_position: Vector2) -> void:
	var fire_direction = (cast_global_position - global_position).normalized()

	var earth_ball: Projectile = Database.game_object_scenes["earth_ball"].instantiate()
	Instance.map.add_child(earth_ball)
	earth_ball.global_position = global_position - earth_ball.size/2
	earth_ball.fire_self(fire_direction)
	pass
	# var earth_ball = 
	# earth_ball.fire_self(get_global_mouse_position() - global_position)


	pass
func skill_earth_platform(cast_global_position: Vector2) -> void:
	
	var earth_platform: Projectile = Database.game_object_scenes["earth_platform"].instantiate()
	Instance.map.add_child(earth_platform)     
	earth_platform.global_position = global_position + Vector2(100,50)
	
	

## do nothing, for when no skill is selected
func skill_null(_cast_global_position: Vector2) -> void:
	pass
func skill_wind(cast_global_position: Vector2) -> void:
	
	var wind_cone = Database.game_object_scenes["wind_cone"].instantiate()
	var cast_direction: Vector2 = (cast_global_position - global_position).normalized()
	wind_cone.direction = cast_direction
	
	Instance.map.add_child(wind_cone)
	wind_cone.global_position = global_position

# open monitoring for circle area
# check then deal damge for enemy inside
# 
func skill_fire(cast_global_position: Vector2) -> void:
	# 
	pass
	## supposed input
	## fire_ball_scene

	var fire_ball = Database.game_object_scenes["fire_ball"].instantiate()
	Instance.map.add_child(fire_ball)
	fire_ball.global_position = cast_global_position - fire_ball.size/2
	

func skill_ice(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)


var holding_electric_ball: Node
func skill_electric(cast_global_position: Vector2) -> void:
	# electric_ball
	if not is_instance_valid(holding_electric_ball):
		holding_electric_ball = Database.game_object_scenes["electric_ball"].instantiate()
		add_child(holding_electric_ball)
		holding_electric_ball.position = -holding_electric_ball.size/2
	else:
		holding_electric_ball.duration = holding_electric_ball.max_duration

func skill_water(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)
func skill_laight(cast_global_position: Vector2) -> void:
	# 
	pass
	skill_earth(cast_global_position)
func skill_arcana(cast_global_position: Vector2) -> void:
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
	"wind": {
		"name": "wind",
		"cd": 1.0,
		"func": skill_wind,
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
	},
	"fire": {
		"name": "fire",
		"cd": 1.0,
		"func": skill_fire,
		"keybind": "6"
	},
	"laight": {
		"name": "laight",
		"cd": 1.0,
		"func": skill_laight,
		"keybind": "7"
	},
	"arcana": {
		"name": "arcana",
		"cd": 1.0,
		"func": skill_arcana,
		"keybind": "8",
	},
	"earth_platform": {
		"name": "earth_platform",
		"cd": 1.0,
		"func": skill_earth_platform,
		"keybind": "9"
	}
	
}

## pretty scuff, for fast testing
var keybind_to_skill: Dictionary[String, String] = {
	"1": "earth",
	"2": "wind",
	"3": "ice",
	"4": "electric",
	"5": "water",
	"6": "fire",
	"7": "laight",
	"8": "arcana",
	"9": "earth_platform"
}

#endregion
