extends Control

## NOTE: possible generalization: negative effect with burning

var shoot_direction: Vector2
@export var burn_tick_time: float = 1.0
@export var burn_tick_damage: int = 3

func execute() -> void:
		for enemy: Enemy in get_tree().get_nodes_in_group("enemy"):
			if effect_area.overlaps_area(enemy.hitbox):
				var hittable_interface: HittableInterface = enemy.get_meta("hittable_interface")
				hittable_interface.take_damage(damage, owner)
				var burning_damage_timer: Timer = Timer.new()
				burning_damage_timer.wait_time = burn_tick_time
				burning_damage_timer.timeout.connect(
					func():
						if is_instance_valid(hittable_interface):
							hittable_interface.take_damage(burn_tick_damage)
				)
