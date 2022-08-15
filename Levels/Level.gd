extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

var machines_scenes = [
	preload("res://Machines/PowerMachine.tscn"),
	preload("res://Machines/MineralMachine.tscn"),
	preload("res://Machines/WaterMachine.tscn"),
	preload("res://Machines/FoodMachine.tscn")
	]

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

