extends KinematicBody2D

signal build_power_machine
signal build_mineral_machine
signal hp_changed

export var MAX_HP = 100
export var NORMAL_SPEED = 3
export var speed_boost_scale = 2

const POWER_MACHINE = 0
const MINERAL_MACHINE = 1

var speed = NORMAL_SPEED
var hp = MAX_HP


var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var current_direction: String = "Down" setget set_current_dir, get_current_dir
var facing = Vector2() setget set_facing, get_facing


func set_current_dir(new_dir: String):
	current_direction = new_dir


func get_current_dir() -> String:
	return current_direction


func get_dir(index: int) -> String:
	return directions[index]


func set_facing(new_facing: Vector2):
	facing = new_facing


func get_facing() -> Vector2:
	return facing


func get_animationSprite () -> Node:
	return $AnimatedSprite


func _ready():
	pass

func _process(_delta):
	if $StateMachine.state.name == "Idle":
		if Input.is_action_just_pressed("BuildPowerMachine"):
			if GameController.can_build_machine(POWER_MACHINE):
				GameController.build_machine(POWER_MACHINE)
				$StateMachine.transition_to("Build")
				emit_signal("build_power_machine")
			else:
				# insert error sound here
				pass
		elif Input.is_action_just_pressed("BuildMineralMachine"):
			if GameController.can_build_machine(MINERAL_MACHINE):
				GameController.build_machine(MINERAL_MACHINE)
				$StateMachine.transition_to("Build")
				emit_signal("build_mineral_machine")
			else:
				# insert error sound here
				pass
	pass

func parse_input():
	pass
