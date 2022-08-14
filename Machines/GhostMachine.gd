extends TextureRect

signal build_machine

var machine
var machine_textures = [
#	preload("res://Machines/.png"),
	preload("res://icon.png"),
	preload("res://icon.png"),
	preload("res://icon.png"),
	preload("res://icon.png"),
]


func _ready():
	connect("build_machine",get_parent(),"_on_build_machine",[get_global_mouse_position(),machine])
#	machine = 
#	self.texture = 
	self.set_position(get_global_mouse_position())


func set_machine(mach_number :int)->void:
	machine = mach_number
	set_texture(machine_textures[mach_number])

func _process(_delta):
	self.set_position(get_global_mouse_position())
	if Input.is_action_just_released("accept_building"):
		if GameController.can_build_machine(machine):
			GameController.build_machine(machine)
			emit_signal("build_machine")
			queue_free()
		else:
			pass
			# insert error sound here
