extends Node

signal Options
signal Controls
signal Languages
signal Paused
signal Refocus

#For section tracking
var Options:bool = false setget set_options
var Controls:bool = false setget set_controls
var Languages:bool = false setget set_languages
var Paused: bool = false setget set_paused

func set_options(value:bool)->void:
	Options = value
	emit_signal("Options", Options)

func set_controls(value:bool)->void:
	Controls = value
	emit_signal("Controls", Controls)

func set_languages(value:bool)->void:
	Languages = value
	emit_signal("Languages", Languages)

func set_paused(value:bool)->void:
	Paused = value
	get_tree().paused = value
	var player = get_tree().get_root().find_node("Player", true, false)
	if player != null:
		player.find_node("Idle",true,false).set_ghost_to_null()
		var ghost = get_tree().get_root().find_node("GhostSprite", true, false)
		if ghost != null:
			ghost.queue_free()
	print_debug(player)
	emit_signal("Paused", Paused)

func _ready()->void:
	pause_mode = Node.PAUSE_MODE_PROCESS										#when pause menu allows reading inputs

func _input(event)->void:												#used to get back in menus
	if event.is_action_pressed("ui_cancel"):
		if Languages:
			set_languages(false)
		elif Controls:
			# ignore back button when entering key
			if !get_tree().get_nodes_in_group("KeyBinding")[0].visible:
				set_controls(false)
			else:
				return
		elif Options:
			set_options(false)
			if PauseMenu.can_show:
				PauseMenu.show_pause_menu(true)
		elif Paused:
			PauseMenu.show_pause_menu(false)
		elif PauseMenu.can_show:
			PauseMenu.show_pause_menu(true)
