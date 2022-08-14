extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

var power_machine_scene = preload("res://Machines/PowerMachine.tscn")
var mineral_machine_scene = preload("res://Machines/MineralMachine.tscn")
var food_machine_scene = preload("res://Machines/FoodMachine.tscn")
var water_machine_scene = preload("res://Machines/WaterMachine.tscn")
var machines_scenes = [power_machine_scene,food_machine_scene,water_machine_scene,mineral_machine_scene]

func _ready()->void:
	Hud.visible = true
	Hud.visible = true
	PauseMenu.can_show = true

func _on_Button_pressed()->void:
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", Next_Scene)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_build_machine(position :Vector2, machine_num: int):
	var machine = machines_scenes[machine_num].instance()
	add_child(machine)
	machine.init(position)
	$Player/StateMachine/Idle.set_ghost_to_null()

