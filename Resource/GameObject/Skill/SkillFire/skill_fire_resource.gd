extends SkillResource


func execute(cast_global_position: Vector2, caster: Player) -> void:
	var fire_ball = main_scene.instantiate()
	Instance.map.add_child(fire_ball)
	fire_ball.global_position = cast_global_position - fire_ball.size/2


	## charge-based effect:

	## 
