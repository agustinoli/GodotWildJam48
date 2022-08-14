extends KinematicBody2D

signal build_power_machine
signal build_mineral_machine
signal hp_changed

export var MAX_HP = 100
export var NORMAL_SPEED = 3
export var speed_boost_scale = 2

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
	if Input.is_action_just_released("zoom_in"):
		$Camera2D.set_zoom($Camera2D.get_zoom()+Vector2(0.1,0.1))
	elif Input.is_action_just_released("zoom_out"):
		$Camera2D.set_zoom($Camera2D.get_zoom()-Vector2(0.1,0.1))


func parse_input():
	pass
