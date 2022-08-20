extends Machine

onready var tilemap = get_parent().get_node("TerraformedFloor")
const tile_index = 4
var terraformed = false

func _ready():
	pass

func _process(_delta):
	if builded and not terraformed:
		terraformed = true
		terraform()

func terraform():
	var coordinates = tilemap.world_to_map(position)
	tilemap.set_cell(coordinates.x	,coordinates.y	,tile_index)
	tilemap.set_cell(coordinates.x+1,coordinates.y	,tile_index)
	tilemap.set_cell(coordinates.x	,coordinates.y+1,tile_index)
	tilemap.set_cell(coordinates.x-1,coordinates.y	,tile_index)
	tilemap.set_cell(coordinates.x	,coordinates.y-1,tile_index)
	
