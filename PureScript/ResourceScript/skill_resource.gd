class_name SkillResource
extends Resource

signal cooldown_timeout
#signal charge_timeout
signal charge_success

@export var id: String = ""
@export var name: String = ""
@export var keybind: String = "skill_9"
@export var max_charge_time: float = 1.0
@export var min_charge_time: float = 0.7
@export var cooldown_time: float = 1.0
@export var description: String = ""
@export var icon: Texture = preload("res://Resource/Texture/wind_cone.png")
@export var main_scene: PackedScene
@export var sub_scene: PackedScene # just for the table to be less messy with different column name

## Refactor explanation:
## instead of having a list of funcs and corresponding skill to call in the player script, the player have
## a list of skill resource which they can
## + know where what binding corressponding to what skill by calling the Database
## + call execute to cast
## + call update_charge_process for charging
## + call update_cooldown_process for cooldown
## + 
##
## Explanation/Intended use: 
## + keybind holded down -> start charging until released, 
## which require player calling update_charge_process using the process func
## + charge duration reach max -> finish and emit a signal and set is_charged to true
## + when charged, the saved count after charging increase by 1, 
## which allow the skill to be combined with other skill, or cast if it's > 1
## + The skill can be casted using the execute function, which require input of where it's casted (mouse pos) and the player casting
## + after casted, the spell goes on cooldown from max to 0, require player calling update_cooldown_process using the process func
## + after cooldown reach 0, the spell can be used (start charging)
## + 
##
## for future changes:
## + charge duration is planned to be used in execute func, so don't set it to 0 after finish charging
## 


#region casting

## let recipe system how many time charged
#var saved_count: int = 0

func execute(_cast_global_position: Vector2, _caster: Player) -> void:
	base_execute_logic()

func base_execute_logic():
	start_cooldown()
	is_charged = false
	#saved_count -= 1
	
#endregion

#region cooldown

var is_on_cooldown: bool = false
var cooldown_duration: float = 0.0

func start_cooldown() -> void:
	is_on_cooldown = false
	cooldown_duration = cooldown_time

func finish_cooldown() -> void:
	is_on_cooldown = false
	cooldown_duration = 0
	cooldown_timeout.emit()

func update_cooldown_process(delta: float) -> void:
	if is_on_cooldown:
		cooldown_duration -= delta
		if cooldown_duration <= 0:
			finish_cooldown() 

#endregion

#region charge
var is_charged: bool = false
var is_on_charge: bool = false
var charged_duration: float = 0.0

func start_charge():
	is_on_charge = true
	charged_duration = 0

func finish_charge():
	stop_charge()
	#saved_count += 1
	if charged_duration > min_charge_time:
		charge_success.emit()
func stop_charge():
	is_on_charge = false
	is_charged = true

func update_charge_process(delta: float) -> void:
	if is_on_charge:
		charged_duration += delta
		if charged_duration > max_charge_time:
			stop_charge()

#endregion
