tool
extends TileMap

export var level = 0 setget _set_level

var available_rooms = 0
var level_properties = {
	1: {"min_num_of_rooms": 5, "max_num_of_rooms": 7, "enemies": [preload("res://scenes/entities/Bat.tscn")], "interactables": []}
}
var room_tile_types = {}

func _set_level(value):
	level = value
	generate_level()

func _ready():
	self.level += 1

func _init():
	# Checks the directory with rooms in them and counts them
	var dir = Directory.new()
	dir.open("res://scenes/rooms/normal")
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			available_rooms -= 1
			break
		else:
			available_rooms += 1

func generate_level():
	clear()
	var current_level_properties = level_properties[level]
	var num_of_rooms = Globals.rng.randi_range(current_level_properties.min_num_of_rooms, current_level_properties.max_num_of_rooms)
	for i in range(num_of_rooms):
		var selected_room = load("res://scenes/rooms/normal/R" + Globals.rng.randi_range(0, available_rooms) + ".tscn")
		
