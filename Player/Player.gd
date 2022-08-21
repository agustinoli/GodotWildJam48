extends KinematicBody2D

export var NORMAL_SPEED = 3

const MIN_ZOOM = 0.5
const MAX_ZOOM = 3.0

var speed = NORMAL_SPEED

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var current_direction: String = "Down" setget set_current_dir, get_current_dir
var facing = Vector2() setget set_facing, get_facing
var movement_sound = preload("res://Assets/Sounds/movement.wav")

var collision


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
	GameController.connect("game_finished", self, "game_finished")
	$AudioStreamPlayer.stream = movement_sound
	$Notebook.visible = false


func _process(_delta):
	if Input.is_action_just_released("zoom_in"):
		var p_zoom = $Camera2D.get_zoom().x+0.1
		p_zoom = clamp(p_zoom, MIN_ZOOM, MAX_ZOOM)
		$Camera2D.set_zoom(Vector2(p_zoom,p_zoom))
	elif Input.is_action_just_released("zoom_out"):
		var p_zoom = $Camera2D.get_zoom().x-0.1
		p_zoom = clamp(p_zoom, MIN_ZOOM, MAX_ZOOM)
		$Camera2D.set_zoom(Vector2(p_zoom,p_zoom))
	elif Input.is_action_just_pressed("ShowNotebook"):
		$Notebook.show()
	
	if collision != null:
		if collision.collider.get_class() == "ChargeStation":
			GameController.player_recharge()


func get_audio_stream():
	return $AudioStreamPlayer


func parse_input():
	pass


func game_finished(won):
	if won:
		$Camera2D/Label.text = "CAMERA1"
	else:
		$Camera2D/Label.text = "CAMERA2"
