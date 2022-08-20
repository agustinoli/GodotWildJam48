extends Machine

onready var tilemap = get_parent().get_node("TerraformedFloor")
const tile_index = 4

func _ready():
	._ready()
	terraform()


func terraform():
	var coordinates = tilemap.world_to_map(position)
#	VER COMO SETEAR EL AUTOTILE PARA ESE TILE_INDEX
	tilemap.set_cell(coordinates.x	,coordinates.y	,tile_index)
	tilemap.set_cell(coordinates.x+1,coordinates.y	,tile_index)
	tilemap.set_cell(coordinates.x	,coordinates.y+1,tile_index)
	tilemap.set_cell(coordinates.x-1,coordinates.y	,tile_index)
	tilemap.set_cell(coordinates.x	,coordinates.y-1,tile_index)
	
