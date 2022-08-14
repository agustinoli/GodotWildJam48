extends Node

const INIT_POWER = 0
const INIT_WATER = 0
const INIT_FOOD  = 0
const INIT_MINE  = 100

const POWER_MACHINE = 0
const MINERAL_MACHINE = 1

var player_power       : int setget set_power, get_power
var player_water       : int setget set_water,get_water
var player_food        : int setget set_food,get_food
var player_mine        : int setget set_mine,get_mine


func _ready():
	player_power = INIT_POWER
	player_water = INIT_WATER
	player_food  = INIT_FOOD
	player_mine  = INIT_MINE


func set_power(p_ele):
	player_power = p_ele


func get_power():
	return player_power


func set_water(p_water):
	player_water = p_water 


func get_water():
	return player_water 


func set_food(p_food):
	player_food = p_food 


func get_food():
	return player_food


func set_mine(p_mine):
	player_mine = p_mine 


func get_mine():
	return player_mine


func player_has_resources(power_cost,food_cost,water_cost,mineral_cost)->bool:
	return (power_cost <= player_power and food_cost <= player_food and water_cost <= player_water and mineral_cost <= player_mine)


func spend_resources(power_cost,food_cost,water_cost,mine_cost)->void:
	player_power -= power_cost
	player_food  -= food_cost
	player_water -= water_cost
	player_mine  -= mine_cost

func gain_resources(power_gain, food_gain, water_gain, mine_gain)->void:
	player_power += power_gain
	player_food  += food_gain
	player_water += water_gain
	player_mine  += mine_gain

func can_build_machine(machine_type):
	match machine_type:
		POWER_MACHINE:
			return player_has_resources(0, 0, 0, 40)
		MINERAL_MACHINE:
			return player_has_resources(70, 0, 0, 60)

func build_machine(machine_type):
	match machine_type:
		POWER_MACHINE:
			spend_resources(0, 0, 0, 40)
			gain_resources(100, 0, 0, 0)
		MINERAL_MACHINE:
			spend_resources(70, 0, 0, 0)
			gain_resources(0, 0, 0, 50)
	
	print(str("Power = ", player_power, " | Food = ", player_food, " | Water = ", player_water, " | Mineral = ", player_mine))
