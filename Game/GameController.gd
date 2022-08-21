extends Node

signal game_finished
signal battery_warning
signal power_warning

const POWER_MACHINE   = 0
const MINERAL_MACHINE = 1
const WATER_MACHINE   = 2
const FOOD_MACHINE    = 3
const TERRA_INDEX_WIN = 10
#                                      P  M    W  F
const INITIAL_RESOURCES            = [ 200, 200, 200, 200, 0 ]
const INITIAL_RESOURCES_DELTA      = [ 0, 0,   0, 0, 0 ]

const INITIAL_MAX_RESOURCES        = [ 200, 200, 200 ,200, TERRA_INDEX_WIN ]
const RESOURCES_MIN                = [ -1, 0, 0 ,0, 0 ]

const POWER_MACHINE_STATIC_COST    = [ 0, 30, 0, 0, 0 ]
const POWER_MACHINE_DYNAMIC_COST   = [ 0, 0,  0, 0, 0 ]
const MINERAL_MACHINE_STATIC_COST  = [ 0, 20, 0, 0, 0 ]
const MINERAL_MACHINE_DYNAMIC_COST = [ 1, 0,  0, 0, 0 ]
const WATER_MACHINE_STATIC_COST    = [ 0, 50, 0, 0, 0 ]
const WATER_MACHINE_DYNAMIC_COST   = [ 5, 1,  0, 0, 0 ]
const FOOD_MACHINE_STATIC_COST     = [ 0, 50, 30, 0, 0 ]
const FOOD_MACHINE_DYNAMIC_COST    = [ 1, 0,  0, 0, 0 ]

const POWER_MACHINE_DYNAMIC_GAIN   = [ 2, 0, 0, 0, 0 ]
const POWER_MACHINE_STATIC_GAIN    = [ 0, 0, 0, 0, 0 ]
const MINERAL_MACHINE_DYNAMIC_GAIN = [ 0, 1, 0, 0, 0 ]
const MINERAL_MACHINE_STATIC_GAIN  = [ 0, 0, 0, 0, 0 ]
const WATER_MACHINE_DYNAMIC_GAIN   = [ 0, 0, 1, 0, 0 ]
const WATER_MACHINE_STATIC_GAIN    = [ 0, 0, 0, 0, 1 ]
const FOOD_MACHINE_DYNAMIC_GAIN = [ 0, 0, 0, 1, 0 ]
const FOOD_MACHINE_STATIC_GAIN  = [ 0, 0, 0, 0, 3 ]

const INITIAL_POWER = 50
const POWER_WARNING = 20

var resources_max
var resources
var resources_delta
var timer
var win
var finished
var player_power
var outro
var power_warning
var battery_warning


func _ready():
	initialize()


func initialize():
	power_warning   = false
	outro           = false
	win             = false
	finished        = false
	player_power    = INITIAL_POWER
	resources       = INITIAL_RESOURCES.duplicate()
	resources_delta = INITIAL_RESOURCES_DELTA.duplicate()
	resources_max   = INITIAL_MAX_RESOURCES.duplicate()
	
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(1)
	timer.connect("timeout", self, "_timer_callback")
	timer.autostart = true
	add_child(timer)
	Hud.set_values(resources,resources_delta)


func decrease_player_power(cant):
	if not finished:
		player_power -= cant
		Hud.set_battery(player_power)
		
		if player_power < 0:
			finished = true
			timer.set_wait_time(5)
			timer.stop()
			timer.start()
			self.disconnect("timeout", self, "_timer_callback")
			timer.connect("timeout", self, "_timer_finished_callback")
			emit_signal("game_finished", false)
		elif player_power < POWER_WARNING:
			emit_signal("battery_warning", true)
			battery_warning = true


func player_recharge():
	if not finished:
		player_power = 100
		Hud.set_battery(player_power)
		if battery_warning:
			emit_signal("battery_warning", false)
			battery_warning = false


func player_has_resources(wanted_resources)->bool:
	if not finished:
		for res in resources.size():
			if wanted_resources[res] > resources[res]:
				return false
		return true
	return false


func spend_resources(spended_resources)->void:
	if not finished:
		for res in resources.size():
			resources[res] -= spended_resources[res]
			if(resources[res] < RESOURCES_MIN[res]):
				resources[res] = RESOURCES_MIN[res]


func gain_resources(gained_resources)->void:
	if not finished:
		for res in resources.size():
			resources[res] += gained_resources[res]
			resources[res] = clamp(resources[res],RESOURCES_MIN[res],resources_max[res])
		
		if not win and resources[resources.size()-1] == INITIAL_MAX_RESOURCES[resources.size()-1]:
			win = true
			finished = true
			timer.set_wait_time(5)
			timer.stop()
			timer.start()
			self.disconnect("timeout", self, "_timer_callback")
			timer.connect("timeout", self, "_timer_finished_callback")
			emit_signal("game_finished", true)


func can_build_machine(machine_type):
	if not finished:
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
	if not finished:
		for res in resources.size():
			resources_delta[res] += new_gain[res]


func add_dynamic_cost(new_cost):
	if not finished:
		for res in resources.size():
			resources_delta[res] -= new_cost[res]


func pre_build_machine(machine_type):
	if not finished:
		match machine_type:
			POWER_MACHINE:
				spend_resources(POWER_MACHINE_STATIC_COST)
			MINERAL_MACHINE:
				spend_resources(MINERAL_MACHINE_STATIC_COST)
			WATER_MACHINE:
				spend_resources(WATER_MACHINE_STATIC_COST)
			FOOD_MACHINE:
				spend_resources(FOOD_MACHINE_STATIC_COST)
		Hud.set_values(resources, resources_delta)


func build_machine(machine_type):
	if not finished:
		match machine_type:
			POWER_MACHINE:
				gain_resources(POWER_MACHINE_STATIC_GAIN)
				add_dynamic_cost(POWER_MACHINE_DYNAMIC_COST)
				add_dynamic_gain(POWER_MACHINE_DYNAMIC_GAIN)
			MINERAL_MACHINE:
				gain_resources(MINERAL_MACHINE_STATIC_GAIN)
				add_dynamic_cost(MINERAL_MACHINE_DYNAMIC_COST)
				add_dynamic_gain(MINERAL_MACHINE_DYNAMIC_GAIN)
			WATER_MACHINE:
				gain_resources(WATER_MACHINE_STATIC_GAIN)
				add_dynamic_cost(WATER_MACHINE_DYNAMIC_COST)
				add_dynamic_gain(WATER_MACHINE_DYNAMIC_GAIN)
			FOOD_MACHINE:
				gain_resources(FOOD_MACHINE_STATIC_GAIN)
				add_dynamic_cost(FOOD_MACHINE_DYNAMIC_COST)
				add_dynamic_gain(FOOD_MACHINE_DYNAMIC_GAIN)
		decrease_player_power(10)


func _timer_callback():
	if not finished:
		if resources_delta[0] >= 0 or resources[0] >= 0: # Si hay deficit de looz, las maquinas no producen
			gain_resources(resources_delta)
		
		if resources_delta[0] < 0:
			emit_signal("power_warning", true)
			power_warning = true
		elif power_warning:
			power_warning = false
			emit_signal("power_warning", false)
			
		Hud.set_values(resources,resources_delta)


func free_timer():
	if not finished:
		timer.disconnect("timeout",self,"_timer_callback")
		timer.queue_free()


func _timer_finished_callback():
	if finished and not outro:
		if win:
			Game.emit_signal("ChangeScene","res://Outro/WinScene.tscn")
		else:
			Game.emit_signal("ChangeScene","res://Outro/LoseScene.tscn")
		outro = true
