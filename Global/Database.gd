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
