class_name RecipeResource
extends Resource


@export var id: String = ""

@export var ingredients: Dictionary[String, int]
@export var results: Dictionary[String, int]

@export var price: int = 1
## what happen on merge
func execute() -> void:
	pass
