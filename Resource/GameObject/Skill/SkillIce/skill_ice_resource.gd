extends SkillResource

@export var offset: Vector2 = Vector2(150, 0)

func execute(cast_global_position: Vector2, caster: Player):
	var ice_cube = main_scene.instantiate()
	Instance.map.add_child(ice_cube)
	var infront_offset: Vector2 = offset * sign(cast_global_position - caster.global_position)

	ice_cube.global_position = caster.global_position + infront_offset
