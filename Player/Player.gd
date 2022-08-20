extends KinematicBody2D


signal hp_changed

export var MAX_POWER = 100
export var NORMAL_SPEED = 3

var speed = NORMAL_SPEED
var power = MAX_POWER

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var current_direction: String = "Down" setget set_current_dir, get_current_dir
var facing = Vector2() setget set_facing, get_facing

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
	$Notebook.visible = false
	#Hud.set_player_power(power)


func _process(_delta):
	if Input.is_action_just_released("zoom_in"):
		$Camera2D.set_zoom($Camera2D.get_zoom()+Vector2(0.1,0.1))
	elif Input.is_action_just_released("zoom_out"):
		$Camera2D.set_zoom($Camera2D.get_zoom()-Vector2(0.1,0.1))
	elif Input.is_action_just_pressed("ShowNotebook"):
		$Notebook.show()
	
	if collision != null:
		if collision.collider.get_class() == "Machine":
			if not collision.collider.is_builded():
				if Input.is_action_just_pressed("FinishBuild"):
					collision.collider.finish_build()
					self.power -= 10
					#Hud.set_player_power(self.power)
		if collision.collider.get_class() == "ChargeStation":
			self.power = MAX_POWER
			#Hud.set_player_power(self.power)


func parse_input():
	pass
