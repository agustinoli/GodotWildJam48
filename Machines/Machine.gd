extends Node2D

class_name Machine

var smoke_scene = preload("res://Particles/Smoke.tscn")
var smoke

func _ready():
	self.visible = false
	
	smoke = smoke_scene.instance()
	smoke.one_shot = true
	smoke.lifetime = 0.3
	smoke.amount = 10
	smoke.scale = Vector2(0.5, 0.5)
	add_child(smoke)
	self.visible = true


func init(init_pos):
	self.position = init_pos
	self.visible = true
