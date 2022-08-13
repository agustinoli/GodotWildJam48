extends Node2D

export (String, FILE, "*.tscn") var Next_Scene: String

var power_plant_scene = preload("res://Machines/PowerMachine.tscn")

func _ready()->void:
	Hud.visible = true
	PauseMenu.can_show = true

func _on_Button_pressed()->void:
	PauseMenu.can_show = false
	Game.emit_signal("ChangeScene", Next_Scene)

func _exit_tree()->void:
	Hud.visible = false
	PauseMenu.can_show = false


func _on_Player_build_power_plant():
	var power_plant = power_plant_scene.instance()
	add_child(power_plant)
	power_plant.init($Player.position + Vector2(0, 50))
	GameController.power_plant_created()
