extends SkillResource

func execute(cast_global_position: Vector2, caster: Player) -> void:
	var fire_direction = (cast_global_position - caster.global_position).normalized()
	var attack_water: Projectile = main_scene.instantiate()
	Instance.map.add_child(attack_water)
	attack_water.global_position = caster.global_position + Vector2(-220,-50)
	attack_water.fire_self(fire_direction)
