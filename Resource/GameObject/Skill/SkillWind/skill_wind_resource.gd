extends SkillResource

func execute(cast_global_position: Vector2, caster: Player) -> void:

	var wind_cone = main_scene.instantiate()
	var cast_direction: Vector2 = (cast_global_position - caster.global_position).normalized()
	wind_cone.direction = cast_direction
	
	Instance.map.add_child(wind_cone)
	wind_cone.global_position = caster.global_position
