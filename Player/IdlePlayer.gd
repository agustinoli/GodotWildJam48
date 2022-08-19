extends State

onready var player = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')
var ghost

onready var ghostMachineScene : PackedScene = load("res://Machines/GhostMachine.tscn")

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func fsm_update(_delta: float) -> void:
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Up") \
		or Input.is_action_pressed("Right") or Input.is_action_pressed("Down"):
		state_machine.transition_to("Move")
	elif Input.is_action_just_pressed("BuildPowerMachine"):
		player.set_notebook_visibility(false)
		make_ghost(GameController.POWER_MACHINE)
	elif Input.is_action_just_pressed("BuildMineralMachine"):
		player.set_notebook_visibility(false)
		make_ghost(GameController.MINERAL_MACHINE)
	elif Input.is_action_just_pressed("BuildWaterMachine"):
		player.set_notebook_visibility(false)
		make_ghost(GameController.WATER_MACHINE)
	elif Input.is_action_just_pressed("BuildFoodMachine"):
		player.set_notebook_visibility(false)
		make_ghost(GameController.FOOD_MACHINE)
	elif Input.is_action_just_pressed("cancel_building"):
			if ghost:
				ghost.queue_free()
				set_ghost_to_null()


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	player.collision = player.move_and_collide(Vector2(0,0))


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass
#	animationSprite.play(player.get_current_dir() + "Idle" )


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


func make_ghost(machine):
	if ghost == null:
		ghost = ghostMachineScene.instance()
		ghost.set_machine(machine)
		ghost.set_position(get_local_mouse_position())
		self.get_tree().get_current_scene().add_child(ghost,true)


func set_ghost_to_null():
	ghost = null
