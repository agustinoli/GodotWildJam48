extends Node

const POWER_MACHINE   = 0
const WATER_MACHINE   = 1
const FOOD_MACHINE    = 2
const MINERAL_MACHINE = 3

#                              P,  W, F, M
const INITIAL_RESOURCES    = [ 0,  0, 0, 100 ]

#                              P,  W, F, M
const POWER_MACHINE_COST   = [ 0,  0, 0, 40  ]
const MINERAL_MACHINE_COST = [ 70, 0, 0, 60  ]

#                              P,   W, F, M
const POWER_MACHINE_GAIN   = [ 100, 0, 0, 0  ]
const MINERAL_MACHINE_GAIN = [ 0,   0, 0, 50 ]

var player_resources setget set_player_resources, get_player_resources


func _ready():
	player_resources = INITIAL_RESOURCES
	print_debug("hola")
	log_player_resources()


func set_player_resources(new_player_resources):
	player_resources = new_player_resources


func get_player_resources():
	return player_resources


func player_has_resources(wanted_resources)->bool:
	for res in 4:
		if wanted_resources[res] > player_resources[res]:
			return false
	return true


func spend_resources(spended_resources)->void:
	for res in 4:
		player_resources[res] -= spended_resources[res]


func gain_resources(gained_resources)->void:
	for res in 4:
		player_resources[res] += gained_resources[res]


func can_build_machine(machine_type):
	match machine_type:
		POWER_MACHINE:
			return player_has_resources(POWER_MACHINE_COST)
		MINERAL_MACHINE:
			return player_has_resources(MINERAL_MACHINE_COST)


func build_machine(machine_type):
	match machine_type:
		POWER_MACHINE:
			spend_resources(POWER_MACHINE_COST)
			gain_resources(POWER_MACHINE_GAIN)
		MINERAL_MACHINE:
			spend_resources(MINERAL_MACHINE_COST)
			gain_resources(MINERAL_MACHINE_GAIN)
	log_player_resources()


func log_player_resources():
	print(str("Power = ", player_resources[0], " | Food = ", player_resources[2], " | Water = ", player_resources[1], " | Mineral = ", player_resources[3]))
