extends Node

class_name Machine

var resource_type


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	pass # Replace with function body.

func init(init_pos):
	self.position = init_pos
	self.visible = true

func generate_resource():
#	usar timer de codigo
	pass

