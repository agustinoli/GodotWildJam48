extends Node

class_name Machine

var smoke_scene = preload("res://Particles/Smoke.tscn")

var resource_type
var smoke

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	
	smoke = smoke_scene.instance()
	smoke.one_shot = true
	smoke.lifetime = 0.3
	smoke.amount = 10
	add_child(smoke)
	

func init(init_pos):
	self.position = init_pos
	self.visible = true

func generate_resource():
#	usar timer de codigo
	pass

