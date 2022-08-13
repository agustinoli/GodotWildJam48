extends Node

const INIT_POWER = 0
const INIT_WATER = 0
const INIT_FOOD  = 0
const INIT_MINE  = 100

var player_power       : int setget set_power, get_power
var player_water       : int setget set_water,get_water
var player_food        : int setget set_food,get_food
var player_mine        : int setget set_mine,get_mine

var power_delta
var water_delta
var food_delta
var mine_delta

var delta_timer


func _ready():
	player_power = INIT_POWER
	player_water = INIT_WATER
	player_food  = INIT_FOOD
	player_mine  = INIT_MINE
	power_delta  = 0
	water_delta  = 0
	food_delta   = 0
	mine_delta   = 0
	delta_timer  = Timer.new()
	delta_timer.set_one_shot(false)
	delta_timer.set_wait_time(1)
	delta_timer.autostart = true
	delta_timer.connect("timeout", self, "_timer_callback")
	delta_timer.start()
	add_child(delta_timer)


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


func _timer_callback():
	print(str("Power = ", player_power, " | Food = ", player_food, " | Water = ", player_water, " | Mineral = ", player_mine))
	player_power += power_delta
	player_food  += food_delta
	player_water += water_delta
	player_mine  += mine_delta


func power_plant_created():
	power_delta += 1
