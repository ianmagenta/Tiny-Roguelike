extends TileMap

export var level = 0 setget _set_level

var level_properties = {
	1: {"num_of_rooms": 5}
}

func _set_level(value):
	level = value
	generate_level()

func generate_level():
	pass
