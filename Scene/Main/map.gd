class_name Map
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Instance.map = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#region scuff/temp

@onready var spawners: Control = $Containers/Spawner
const JOHN_GODOT = preload("res://Resource/GameObject/Enemy/JohnGodot/john_godot.tscn")

func random_spawn_enemy():
	var random_spawner: Control = spawners.get_children().pick_random()
	var random_pos: Vector2 = random_spawner.global_position + Vector2(randi_range(0, random_spawner.size.x), randi_range(0, random_spawner.size.y))
	var new_enemy = JOHN_GODOT.instantiate()
	
	Instance.map.add_child(new_enemy)
	new_enemy.global_position = random_pos
	
func _on_spawn_timer_timeout() -> void:
	random_spawn_enemy()
	
#endregion
