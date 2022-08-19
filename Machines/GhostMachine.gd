extends Sprite

signal build_machine

var machine
var machine_textures = [
	preload("res://Assets/Images/Machines/Energy.png"),
	preload("res://Assets/Images/Machines/Mineral.png"),
	preload("res://Assets/Images/Machines/Water.png"),
	preload("res://Assets/Images/Machines/Food.png")
	]

onready var parent = get_parent()
onready var moon = parent.get_moon_floor_tilemap()
onready var moon_obj = parent.get_moon_floor_objects_tilemap()
var good_terrain = true


func _ready():
	connect("build_machine",get_parent(),"_on_build_machine")
	self.set_position(get_global_mouse_position())

func set_machine(mach_number :int)->void:
	machine = mach_number
	set_texture(machine_textures[mach_number])

func _process(_delta):
	var map_object_index = moon_obj.world_to_map(get_global_mouse_position())
	var map_index = moon.world_to_map(get_global_mouse_position())
	self.set_position(parent.get_moon_floor_tilemap().map_to_world(map_index))
	check_collision(map_object_index,map_index)
	if Input.is_action_just_released("accept_building") and good_terrain:
		if GameController.can_build_machine(machine):
			emit_signal("build_machine",position,machine)
			queue_free()
		else:
#			SfxManager.play("file_name_without_extension")
			pass

func check_collision(map_object_index,map_index):
	# if $Area2D.get_overlapping_areas().size() != 0:
		# print_debug($Area2D.get_overlapping_areas())
	if moon_obj.get_cellv(map_object_index) == -1 and \
		 moon.get_cellv(map_index) != -1 and \
			$Area2D.get_overlapping_areas().size() == 0:
		set_modulate(Color(0,1,0,1))
		good_terrain = true
	else:
		set_modulate(Color(1,0,0,1))
		good_terrain = false
	
