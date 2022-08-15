extends TextureRect

signal build_machine

var machine
var machine_textures = [
#	preload("res://Assests/Images/Machines.png"),
	preload("res://icon.png"),
	preload("res://icon.png"),
	preload("res://icon.png"),
	preload("res://icon.png"),
	]
onready var parent = get_parent()

func _ready():
	connect("build_machine",get_parent(),"_on_build_machine")
	self.set_position(get_global_mouse_position())

func set_machine(mach_number :int)->void:
	machine = mach_number
	set_texture(machine_textures[mach_number])

func _process(_delta):
	var map_index = parent.get_tilemap().world_to_map(get_global_mouse_position())
	self.set_position(parent.get_tilemap().map_to_world(map_index))
#	Old way:
#	self.set_position(get_global_mouse_position()-(get_texture().get_size())/2)
	if Input.is_action_just_released("accept_building"):
		if GameController.can_build_machine(machine):
			GameController.build_machine(machine)
			emit_signal("build_machine",get_global_mouse_position(),machine)
			queue_free()
		else:
#			SfxManager.play("file_name_without_extension")
			pass
