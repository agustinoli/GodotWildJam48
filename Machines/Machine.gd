extends StaticBody2D

class_name Machine

var smoke_scene = preload("res://Particles/Smoke.tscn")
var smoke
var machine_type
var builded

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


func get_class():
	if not builded:
		return "Machine"
	else:
		return "Chanchada"

