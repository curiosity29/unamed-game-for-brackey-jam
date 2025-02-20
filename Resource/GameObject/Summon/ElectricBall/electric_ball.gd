extends Control


@export var max_duration: float = 7.
var duration: float
@export var damage: int = 2
@onready var effect_area: Area2D = $EffectArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	duration = max_duration


func execute():
	
	for enemy: Enemy in get_tree().get_nodes_in_group("enemy"):
		if effect_area.overlaps_area(enemy.hitbox):
			var hittable_interface: HittableInterface = enemy.get_meta("hittable_interface")
			hittable_interface.take_damage(damage, owner)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if duration > 0:
		duration -= delta
	else:
		queue_free()

func _on_strike_timer_timeout() -> void:
	execute()
