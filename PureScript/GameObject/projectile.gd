class_name Projectile
extends Control

var move_speed: float = 500.0
var fire_direction: Vector2 = Vector2.ZERO


func fire_self(direction) -> void:
	fire_direction = direction


func _process(delta: float) -> void:
	if fire_direction:
		global_position += fire_direction * move_speed * delta
	
	check_out_of_screen()



func check_out_of_screen() -> void:
	if min(global_position.x, global_position.y) <-1000 or max(global_position.x, global_position.y) > get_viewport_rect().size.x + 1000 :
		queue_free()
