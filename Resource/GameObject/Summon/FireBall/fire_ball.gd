extends Control

@onready var effect_area: Area2D = $EffectArea

@export var damage: int = 10
var repeat_damage_count: int = 5
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var burn_timer: Timer = $BurnTimer


func execute():
	
	for enemy: Enemy in get_tree().get_nodes_in_group("enemy"):
		if effect_area.overlaps_area(enemy.hitbox):
			var hittable_interface: HittableInterface = enemy.get_meta("hittable_interface")
			hittable_interface.take_damage(damage, owner)
		else:
			pass
	


func _on_burn_timer_timeout() -> void:
	repeat_damage_count -= 1
	execute()
	if repeat_damage_count == 0:
		queue_free()


func _on_start_timer_timeout() -> void:
	execute()
	burn_timer.start()
