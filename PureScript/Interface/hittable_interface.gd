class_name HittableInterface
extends Object

var health = 100
var max_health = 100
var owner: Node


# Called when the node enters the scene tree for the first time.
func _init(init_max_health: int, init_owner: Node) -> void:
	max_health = init_max_health
	owner = init_owner
	health = max_health

	owner.set_meta("hittable_interface", self)
	
func take_damage(damage: int, _source: Node = null) -> void:
	health -= damage
