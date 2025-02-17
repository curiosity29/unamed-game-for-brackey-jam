class_name DamageArea
extends Area2D

@export var damage: int = 10
@export var destroy_owner_hit: bool = false

func _ready() -> void:
	area_entered.connect(deal_damage)


func deal_damage(area: Area2D) -> void:
	var area_owner = area.owner
	if area_owner.has_meta("hittable_interface"):
		var hittable_interface: HittableInterface = area_owner.get_meta("hittable_interface")
		hittable_interface.take_damage(damage)

	if destroy_owner_hit:
		owner.queue_free()
