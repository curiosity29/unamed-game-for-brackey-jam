extends Node2D




## temp
var game_object_scenes: Dictionary[String, PackedScene] = {
	"earth_ball": load("res://Resource/GameObject/Summon/EarthBall/earth_ball.tscn"),
	"earth_platform": load("res://Resource/GameObject/Summon/earth_platform/creating_earth_platform.tscn"),
	"fire_ball": load("res://Resource/GameObject/Summon/FireBall/fire_ball.tscn"),
	"wind_cone": load("res://Resource/GameObject/Summon/WindCone/wind_cone.tscn"),
	"electric_ball": load("res://Resource/GameObject/Summon/ElectricBall/electric_ball.tscn"),
	"attack_water": load("res://Resource/GameObject/Summon/water/water_attack/water_attack.tscn")
	
}

var _all_skills: ResourceGroup = preload("res://Resource/ResourceGroup/all_skills.tres")
var all_skills: Array[SkillResource]
var skills_map: Dictionary[String, SkillResource] ## id to resource
var keybind_to_skill_map: Dictionary[String, SkillResource] ## binding to resource

var _all_recipes: ResourceGroup = preload("res://Resource/ResourceGroup/all_recipes.tres")
var all_recipes: Array[RecipeResource]
var recipes_map: Dictionary[String, RecipeResource]

func _ready() -> void:
	_all_skills.load_all_into(all_skills)
	for skill_resource: SkillResource in all_skills:
		skills_map[skill_resource.id] = skill_resource
		keybind_to_skill_map[skill_resource.keybind] = skill_resource
		

	_all_recipes.load_all_into(all_recipes)
	for recipe_resource: RecipeResource in all_recipes:
		recipes_map[recipe_resource.id] = recipe_resource
