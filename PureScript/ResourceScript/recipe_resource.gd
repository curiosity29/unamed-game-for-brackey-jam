class_name RecipeResource
extends Resource


@export var id: String = ""

@export var ingredients: Dictionary[String, int]
@export var results: Dictionary[String, int]

## what happen on merge
func execute() -> void:
	pass
