extends StaticBody2D

class_name Machine

var smoke_scene = preload("res://Particles/Smoke.tscn")
var smoke
var machine_type
var builded
var timer

func _ready():
	self.visible = false
	smoke = smoke_scene.instance()
	smoke.one_shot = true
	smoke.lifetime = 0.3
	smoke.amount = 10
	smoke.scale = Vector2(0.5, 0.5)
	add_child(smoke)
	builded = false
	modulate.a = 0.5
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(0.5)
	timer.connect("timeout", self, "_timer_callback")
	timer.autostart = true
	add_child(timer)


func init(init_pos, machi_type):
	self.position = init_pos
	self.visible = true
	self.machine_type = machi_type
	GameController.pre_build_machine(self.machine_type)


func finish_build():
	if not builded:
		GameController.build_machine(self.machine_type)
		modulate.a = 1
		builded = true
		timer.disconnect("timeout", self, "_timer_callback")
		timer.queue_free()


func get_class():
	return "Machine"


func is_builded():
	return builded


func _timer_callback():
	if self.modulate.a == 0.5:
		self.modulate.a = 1
	else:
		self.modulate.a = 0.5
