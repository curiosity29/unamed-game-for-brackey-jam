extends SkillResource

@export var damage: int = 15
@export var steam_force: float = 3000
## same as fire but with push and more damage


func execute(cast_global_position, caster: Player):
	var steam_scene = main_scene.instantiate()
	Instance.map.add_child(steam_scene)
	steam_scene.global_position = caster.global_position
	steam_scene.steam_force = steam_force
	pass
