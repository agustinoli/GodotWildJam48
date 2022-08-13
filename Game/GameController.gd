extends Node

var player_electricity : int setget set_elect, get_elect
var player_water       : int setget set_water,get_water
var player_food        : int setget set_food,get_food

func _ready():
	player_electricity = 0
	player_water       = 0
	player_food        = 0


func set_elect(p_ele):	
	player_electricity = p_ele
	

func get_elect():
	return player_electricity


func set_water(p_water):
	player_water = p_water 
	

func get_water():
	return player_water 


func set_food(p_food):
	player_food = p_food 
	

func get_food():
	return player_food
