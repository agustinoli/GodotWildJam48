extends Node

onready var mineral: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/HP/MineralNum
onready var power: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/HP/PowerNum
onready var food: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/HP/FoodNum
onready var water: = $CanvasLayer/GUI/MarginContainer/VBoxContainer/Top/HP/WaterNum
onready var gui: = $CanvasLayer/GUI

var visible: = false setget set_visible

func _ready()->void:
	gui.visible = visible

func set_visible(value: bool)->void:
	visible = value
	gui.visible = value

func set_values(new_power,new_food,new_water,new_mineral):
	power.set_text(new_power)
	food.set_text(new_food)
	water.set_text(new_water)
	mineral.set_text(new_mineral)
