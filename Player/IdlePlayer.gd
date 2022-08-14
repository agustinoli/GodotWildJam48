extends State

onready var player = self.get_node('../../')
onready var animationSprite = self.get_node('../../AnimatedSprite')


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Up") or Input.is_action_pressed("Right") or Input.is_action_pressed("Down"):
		state_machine.transition_to("Move")
	elif Input.is_action_just_pressed("BuildPowerMachine"):
		if GameController.can_build_machine(GameController.POWER_MACHINE):
			GameController.build_machine(GameController.POWER_MACHINE)
			state_machine.transition_to("Build")
			player.emit_signal("build_power_machine")
		else:
			# insert error sound here
			pass
	elif Input.is_action_just_pressed("BuildMineralMachine"):
		if GameController.can_build_machine(GameController.MINERAL_MACHINE):
			GameController.build_machine(GameController.MINERAL_MACHINE)
			state_machine.transition_to("Build")
			player.emit_signal("build_mineral_machine")
		else:
			# insert error sound here
			pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	animationSprite.play(player.get_current_dir() + "Idle" )


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
