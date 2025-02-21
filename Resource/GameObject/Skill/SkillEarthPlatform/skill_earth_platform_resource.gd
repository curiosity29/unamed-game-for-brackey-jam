extends SkillResource


func execute(_cast_global_position: Vector2, caster: Player) -> void:
	var earth_platform: Projectile = main_scene.instantiate()
	Instance.map.add_child(earth_platform)     
	earth_platform.global_position = caster.global_position + Vector2(100,50)
