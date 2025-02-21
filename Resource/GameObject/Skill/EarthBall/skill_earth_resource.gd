extends SkillResource


func execute(cast_global_position: Vector2, caster: Player) -> void:
	var fire_direction = (cast_global_position - caster.global_position).normalized()

	var earth_ball: Projectile = main_scene.instantiate()
	Instance.map.add_child(earth_ball)
	earth_ball.global_position = caster.global_position - earth_ball.size/2
	earth_ball.fire_self(fire_direction)
