extends TextureRect

const POWER_MACHINE = 0
const MINERAL_MACHINE = 1
var machine

func _ready():
#	machine = 
#	self.texture = 
	self.set_position(get_global_mouse_position())


func set_machine(mach :int)->void:
	machine = mach

func _process(_delta):
	self.set_position(get_global_mouse_position())
	if Input.is_action_just_released("ui_accept"):
		print_debug('entre a construir maquina')
		if GameController.can_build_machine(machine):
			GameController.build_machine(machine)
#			$StateMachine.transition_to("Build")
			emit_signal("build_power_machine")
