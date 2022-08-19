extends Node

onready var mineral: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/MineralNum
onready var power: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/PowerNum
onready var food: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/FoodNum
onready var water: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/WaterNum
onready var battery: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/Barrita/BarritaAdentro
onready var gui: = $CanvasLayer/GUI
onready var res_labels = [power,mineral,food,water]

var visible: = false setget set_visible

func _ready()->void:
	gui.visible = visible
	set_values(GameController.INITIAL_RESOURCES)

func set_visible(value: bool)->void:
	visible = value
	gui.visible = value

func set_values(new_res):
#	for i in res_labels:
#		res_labels[i].set_text(new_res[i])
	power.set_text(str(new_res[0]))
	mineral.set_text(str(new_res[1]))
	food.set_text(str(new_res[2]))
	water.set_text(str(new_res[3]))
	

func set_battery(percentage):
	pass
#	mmm parece qe no es rec_clip_content
#	battery.rect_clip_content(battery.rect_size()/2)
	
