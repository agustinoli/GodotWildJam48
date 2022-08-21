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
	PauseMenu.can_show = true

func _on_Button_pressed()->void:
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", Next_Scene)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false

func get_moon_floor_tilemap():
	return $MoonFloor

func get_moon_floor_objects_tilemap():
	return $YSort/MoonFloorObjects

func get_terraformed_floor_tilemap():
	return $TerraformedFloor

func get_terraformed_floor_objects_tilemap():
	return $YSort/TerraformedFloorObjects

func _on_build_machine(position :Vector2, machine_num: int):
	var machine = machines_scenes[machine_num].instance()
	machine.init(position, machine_num)
	$YSort.add_child(machine)
	$YSort/Player/StateMachine/Idle.set_ghost_to_null()
	SfxManager.play("PonerMaquina")

