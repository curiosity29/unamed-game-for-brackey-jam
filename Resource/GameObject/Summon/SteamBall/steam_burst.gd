extends Control

@onready var effect_area: Area2D = $EffectArea
@export var steam_force: float = 2500.
@export var damage: int = 10

func execute() -> void:
	for enemy: Enemy in get_tree().get_nodes_in_group("enemy"):
		if effect_area.overlaps_area(enemy.hitbox):
			var hittable_interface: HittableInterface = enemy.get_meta("hittable_interface")
			hittable_interface.take_damage(damage, owner)
			var push_direction: Vector2 = (enemy.global_position - global_position).normalized()
			enemy.velocity += push_direction * steam_force
