extends Area2D

class_name Machine

var smoke_scene = preload("res://Particles/Smoke.tscn")
var smoke
var machine_type
var builded
var timer
var player_near

func _ready():
	self.visible = false
	smoke = smoke_scene.instance()
	smoke.one_shot = true
	smoke.lifetime = 0.3
	smoke.amount = 10
	smoke.scale = Vector2(0.5, 0.5)
	add_child(smoke)
	builded = false
	$Body.modulate.a = 0.5
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(0.5)
	timer.connect("timeout", self, "_timer_callback")
	timer.autostart = true
	add_child(timer)
	connect("body_entered", self, "_body_entered")
	connect("body_exited", self, "_body_exited")
	self.visible = true


func init(init_pos, machi_type):
	self.position = init_pos
	self.machine_type = machi_type
	GameController.pre_build_machine(self.machine_type)


func finish_build():
	if not builded:
		GameController.build_machine(self.machine_type)
		$Body.modulate.a = 1
		builded = true
		timer.disconnect("timeout", self, "_timer_callback")
		timer.queue_free()


func get_class():
	return "Machine"


func is_builded():
	return builded


func _timer_callback():
	if $Body.modulate.a == 0.5:
		$Body.modulate.a = 1
	else:
		$Body.modulate.a = 0.5


func _process(_delta):
	if player_near and Input.is_action_just_pressed("FinishBuild"):
		finish_build()
	

func _body_entered(body):
	if body.get_name() == "Player":
		player_near = true


func _body_exited(body):
	if body.get_name() == "Player":
		player_near = false
