class_name HittableInterface
extends Object

var health = 100:
	set(value):
		health = value
		if health <= 0 and not is_dead:
			is_dead = true
			if do_queue_free_owner_on_death:
				owner.queue_free()
				call_deferred("free")
				
var max_health = 100
var owner: CharacterBody2D

var do_queue_free_owner_on_death: bool = true
var is_dead: bool = false

# Called when the node enters the scene tree for the first time.
func _init(init_max_health: int, init_owner: Node) -> void:
	max_health = init_max_health
	owner = init_owner
	health = max_health

	owner.set_meta("hittable_interface", self)
	
func take_damage(damage: int, _source: Node = null) -> void:
	health -= damage
	VisualHelper.show_damage_indicator(str(damage), owner.global_position)
