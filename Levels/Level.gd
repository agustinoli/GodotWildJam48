extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

var power_machine_scene = preload("res://Machines/PowerMachine.tscn")
var mineral_machine_scene = preload("res://Machines/MineralMachine.tscn")

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true

func _on_Button_pressed()->void:
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", Next_Scene)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_Player_build_power_machine():
	var power_machine = power_machine_scene.instance()
	add_child(power_machine)
	power_machine.init($Player.position + Vector2(0, 50))


func _on_Player_build_mineral_machine():
	var mineral_machine = mineral_machine_scene.instance()
	add_child(mineral_machine)
	mineral_machine.init($Player.position + Vector2(0, 50))
