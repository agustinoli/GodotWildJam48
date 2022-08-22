extends Node

onready var mineral: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/MineralNum
onready var power: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/PowerNum
onready var food: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/FoodNum
onready var water: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/WaterNum
onready var mineral_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/MineralDelta
onready var power_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/PowerDelta
onready var food_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/FoodDelta
onready var water_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/WaterDelta
onready var battery: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/BatteryNum
onready var terra: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/TerraIndexNum
onready var gui: = $CanvasLayer/GUI
onready var res_labels = [power,mineral,food,water]

var visible: = false setget set_visible

onready var bat_x = GameController.INITIAL_POWER

func _ready()->void:
	gui.visible = visible
#	battery.set_region(true)
#	battery.set_region_rect(Rect2(Vector2(0,0),Vector2(GameController.INITIAL_POWER,24)))
	set_values(GameController.INITIAL_RESOURCES,GameController.INITIAL_RESOURCES_DELTA)
	set_battery(GameController.INITIAL_POWER)

func set_visible(value: bool)->void:
	visible = value
	gui.visible = value

func set_values(new_res,new_deltas):
	power.set_text(str(new_res[0]))
	mineral.set_text(str(new_res[1]))
	water.set_text(str(new_res[2]))
	food.set_text(str(new_res[3]))
	terra.set_text(str(new_res[4],"/",GameController.TERRA_INDEX_WIN))
	power_delta.set_text(str(new_deltas[0])+"/s")
	mineral_delta.set_text(str(new_deltas[1])+"/s")
	water_delta.set_text(str(new_deltas[2])+"/s")
	food_delta.set_text(str(new_deltas[3])+"/s")

func set_battery(value):
	battery.set_text(str(value)+"%")


	
