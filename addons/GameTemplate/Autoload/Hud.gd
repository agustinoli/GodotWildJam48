extends Node

onready var mineral: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/MineralNum
onready var power: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/PowerNum
onready var food: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/FoodNum
onready var water: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/WaterNum
onready var mineral_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/MineralDelta
onready var power_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/PowerDelta
onready var food_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/FoodDelta
onready var water_delta: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/WaterDelta
onready var battery: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/Barrita/BarritaAdentro
onready var gui: = $CanvasLayer/GUI
onready var res_labels = [power,mineral,food,water]

var visible: = false setget set_visible

func _ready()->void:
	gui.visible = visible
	set_values(GameController.INITIAL_RESOURCES,GameController.INITIAL_RESOURCES_DELTA)
	set_battery(100)

func set_visible(value: bool)->void:
	visible = value
	gui.visible = value

func set_values(new_res,new_deltas):
	power.set_text(str(new_res[0]))
	mineral.set_text(str(new_res[1]))
	food.set_text(str(new_res[2]))
	water.set_text(str(new_res[3]))
	power_delta.set_text(str(new_deltas[0])+"/s")
	mineral_delta.set_text(str(new_deltas[1])+"/s")
	food_delta.set_text(str(new_deltas[2])+"/s")
	water_delta.set_text(str(new_deltas[3])+"/s")
	

func set_battery(percentage):
	pass
#	mmm parece qe no es rec_clip_content
#	battery.rect_clip_content(battery.rect_size()/2)

