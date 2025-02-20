extends Control

@onready var effect_area: Area2D = $EffectArea

var base_direction: Vector2 = Vector2.ONE.normalized()
var direction: Vector2 = Vector2.ONE.normalized()
var wind_force = 5000

func _ready() -> void:
	rotation = base_direction.angle_to(direction)

func execute() -> void:
	for enemy: Enemy in get_tree().get_nodes_in_group("enemy"):
		if effect_area.overlaps_area(enemy.hitbox):
			enemy.velocity += direction * wind_force
