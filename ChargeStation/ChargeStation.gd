extends Area2D

var player_near


func _ready():
	player_near = false


func get_class():
	return "ChargeStation"


func _process(_delta):
	if player_near and Input.is_action_just_pressed("FinishBuild"):
		GameController.player_recharge()


func _on_ChargeStation_body_exited(body):
	if body.get_name() == "Player":
		player_near = false


func _on_ChargeStation_body_entered(body):
	if body.get_name() == "Player":
		player_near = true
