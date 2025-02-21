extends AnimatedSprite2D
var rotated: bool = true
func _process(delta):
	if rotated:
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		rotation = direction.angle() 
		rotated = false 


	
 
