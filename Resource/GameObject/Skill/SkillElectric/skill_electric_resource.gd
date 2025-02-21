extends SkillResource


var holding_electric_ball: Node
func execute(_cast_global_position: Vector2, caster: Player) -> void:
	if not is_instance_valid(holding_electric_ball):
		holding_electric_ball = main_scene.instantiate()
		caster.add_child(holding_electric_ball)
		holding_electric_ball.position = -holding_electric_ball.size/2
	else:
		holding_electric_ball.duration = holding_electric_ball.max_duration
