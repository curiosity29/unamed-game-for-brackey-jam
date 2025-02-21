class_name Player
extends CharacterBody2D

var move_speed: float = 800
var acceleration_mult: float = 10.
var friction_mult: float = 5.
var jump_velocity: int = -2500
var is_moving: bool = false
var gravity_mult: float = 8.
var current_skill: Callable


var hittable_interface: HittableInterface
var current_direction: Vector2

var anim_sprite: AnimatedSprite2D
@export var health: int = 100

## NOTE: currently let player have all the skill
var all_skills: Array[SkillResource]

var charged_skills: Dictionary[String, int] = {}
var recipe_manager: RecipeSystem = RecipeSystem.new()
var last_charged_skill: SkillResource:
	get:
		if recipe_manager.inventory.is_empty(): return null
		return Database.skills_map[recipe_manager.inventory.keys()[recipe_manager.inventory.size()-1]]

func _ready() -> void:
	Instance.player = self
	anim_sprite = $AnimatedSprite2D
	
	hittable_interface = HittableInterface.new(health, self)
	init_skills()
	
func init_skills():
	all_skills = Database.all_skills
	
	## for when charge system is setup
	#for skill_resource: SkillResource in all_skills:
		#skill_resource.charge_timeout.connect(func(): recipe_manager.add_ingredient_to_inventory(skill_resource.id))



func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	if event.is_action_pressed("right_click"):
		is_moving = true

	elif event.is_action_released("right_click"):
		is_moving = false
	if event.is_action_pressed("click"):
		if last_charged_skill: 
			last_charged_skill.execute(mouse_pos, self)
			recipe_manager.subtract_ingredient_to_inventory(last_charged_skill.id)

		
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity

	## temporary instant effect before charging system is setup
	for skill_resource: SkillResource in all_skills:
		if Input.is_action_pressed(skill_resource.keybind):
			recipe_manager.add_ingredient_to_inventory(skill_resource.id)
			#print("added skill: %s" % skill_resource.name)
	
## move toward the mouse position if holding right click
func _physics_process(delta: float) -> void:
	# global_position = move_toward(global_position, get_global_mouse_position(), delta * move_speed)
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_mult
		
	var direction_value = Input.get_axis("left", "right")
	if direction_value < 0:
		current_direction = Vector2.LEFT
		#anim_sprite.flip_h = true
	elif direction_value > 0:
		current_direction = Vector2.RIGHT
		#anim_sprite.flip_h = false
	
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
	
	if direction_value: update_animation(current_direction)
	else: update_animation(Vector2.ZERO)
		
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
