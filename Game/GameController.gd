extends Node

const POWER_MACHINE   = 0
const MINERAL_MACHINE = 1
const WATER_MACHINE   = 2
const FOOD_MACHINE    = 3

#                                      P  M    W  F
const INITIAL_RESOURCES            = [ 200, 200, 200, 200 ]
const INITIAL_RESOURCES_DELTA      = [ 0, 0,   0, 0 ]

const RESOURCES_MAX                = [ 200, 200, 200 ,200 ]
const RESOURCES_MIN                = [ -1, 0, 0 ,0 ]

const POWER_MACHINE_STATIC_COST    = [ 0, 30, 0, 0 ]
const POWER_MACHINE_DYNAMIC_COST   = [ 0, 0,  0, 0 ]
const MINERAL_MACHINE_STATIC_COST  = [ 0, 20, 0, 0 ]
const MINERAL_MACHINE_DYNAMIC_COST = [ 1, 0,  0, 0 ]
const WATER_MACHINE_STATIC_COST    = [ 0, 50, 0, 0 ]
const WATER_MACHINE_DYNAMIC_COST   = [ 5, 1,  0, 0 ]
const FOOD_MACHINE_STATIC_COST     = [ 0, 50, 30, 0 ]
const FOOD_MACHINE_DYNAMIC_COST    = [ 1, 0,  0, 0 ]

const POWER_MACHINE_DYNAMIC_GAIN   = [ 2, 0, 0, 0 ]
const POWER_MACHINE_STATIC_GAIN    = [ 0, 0, 0, 0 ]
const MINERAL_MACHINE_DYNAMIC_GAIN = [ 0, 1, 0, 0 ]
const MINERAL_MACHINE_STATIC_GAIN  = [ 0, 0, 0, 0 ]
const WATER_MACHINE_DYNAMIC_GAIN   = [ 0, 0, 1, 0 ]
const WATER_MACHINE_STATIC_GAIN    = [ 0, 0, 0, 0 ]
const FOOD_MACHINE_DYNAMIC_GAIN = [ 0, 0, 0, 1 ]
const FOOD_MACHINE_STATIC_GAIN  = [ 0, 0, 0, 0 ]


var resources
var resources_delta
var timer

func _ready():
	initialize()


func initialize():	
	resources       = INITIAL_RESOURCES.duplicate()
	resources_delta = INITIAL_RESOURCES_DELTA.duplicate()
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(1)
	print_debug(INITIAL_RESOURCES)
	timer.connect("timeout", self, "_timer_callback")
	timer.autostart = true
	add_child(timer)
	Hud.set_values(resources)


func player_has_resources(wanted_resources)->bool:
	for res in 4:
		if wanted_resources[res] > resources[res]:
			return false
	return true


func spend_resources(spended_resources)->void:
	for res in 4:
		resources[res] -= spended_resources[res]
		if(resources[res] < RESOURCES_MIN[res]):
			resources[res] = RESOURCES_MIN[res]


func gain_resources(gained_resources)->void:
	for res in 4:
		resources[res] += gained_resources[res]
		if(resources[res] > RESOURCES_MAX[res]):
			resources[res] = RESOURCES_MAX[res]
		if(resources[res] < RESOURCES_MIN[res]): # Esto debido a los deltas
			resources[res] = RESOURCES_MIN[res]


func can_build_machine(machine_type):
	match machine_type:
		POWER_MACHINE:
			return player_has_resources(POWER_MACHINE_STATIC_COST)
		MINERAL_MACHINE:
			return player_has_resources(MINERAL_MACHINE_STATIC_COST)
		WATER_MACHINE:
			return player_has_resources(WATER_MACHINE_STATIC_COST)
		FOOD_MACHINE:
			return player_has_resources(FOOD_MACHINE_STATIC_COST)


func add_dynamic_gain(new_gain):
	for res in 4:
		resources_delta[res] += new_gain[res]


func add_dynamic_cost(new_cost):
	for res in 4:
		resources_delta[res] -= new_cost[res]


func build_machine(machine_type):
	match machine_type:
		POWER_MACHINE:
			spend_resources(POWER_MACHINE_STATIC_COST)
			gain_resources(POWER_MACHINE_STATIC_GAIN)
			add_dynamic_cost(POWER_MACHINE_DYNAMIC_COST)
			add_dynamic_gain(POWER_MACHINE_DYNAMIC_GAIN)
		MINERAL_MACHINE:
			spend_resources(MINERAL_MACHINE_STATIC_COST)
			gain_resources(MINERAL_MACHINE_STATIC_GAIN)
			add_dynamic_cost(MINERAL_MACHINE_DYNAMIC_COST)
			add_dynamic_gain(MINERAL_MACHINE_DYNAMIC_GAIN)
		WATER_MACHINE:
			spend_resources(WATER_MACHINE_STATIC_COST)
			gain_resources(WATER_MACHINE_STATIC_GAIN)
			add_dynamic_cost(WATER_MACHINE_DYNAMIC_COST)
			add_dynamic_gain(WATER_MACHINE_DYNAMIC_GAIN)
		FOOD_MACHINE:
			spend_resources(FOOD_MACHINE_STATIC_COST)
			gain_resources(FOOD_MACHINE_STATIC_GAIN)
			add_dynamic_cost(FOOD_MACHINE_DYNAMIC_COST)
			add_dynamic_gain(FOOD_MACHINE_DYNAMIC_GAIN)


func _timer_callback():
	if resources_delta[0] >= 0 or resources[0] >= 0: # Si hay deficit de looz, las maquinas no producen
		gain_resources(resources_delta)
	Hud.set_values(resources)
	log_player_resources()


func free_timer():
	timer.disconnect("timeout",self,"_timer_callback")
	timer.queue_free()


func log_player_resources():
	print(str(	"Power = ", resources[0], " (", resources_delta[0], "/s) | ",
				"Mineral = ", resources[1], " (", resources_delta[1], "/s) | ",
				"Water = ", resources[2], " (", resources_delta[2], "/s) | ",
				"Food = ", resources[3], " (", resources_delta[3], "/s)"
				))
