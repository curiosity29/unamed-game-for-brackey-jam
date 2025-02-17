class_name DamageArea
extends Area2D

@export var damage: int = 10
@export var destroy_owner_hit: bool = false

func _ready() -> void:
	area_entered.connect(deal_damage)


func deal_damage(area: Area2D) -> void:
	var area_onwer = area.owner
	if area_onwer.has_method("take_damage"):
		area_onwer.take_damage(damage)

	if destroy_owner_hit:
		owner.queue_free()
