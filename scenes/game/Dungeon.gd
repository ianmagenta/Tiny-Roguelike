tool
extends TileMap

export var level = 0 setget _set_level

var available_rooms = 0
var room_walls : TileMap
var size = Vector2(6, 1)
var level_props = [
	{"min_num_of_rooms": 5, "max_num_of_rooms": 7, "enemies": [preload("res://scenes/entities/Bat.tscn")], "interactables": [], "wall_type": 0},
	{"min_num_of_rooms": 5, "max_num_of_rooms": 7, "enemies": [preload("res://scenes/entities/Bat.tscn")], "interactables": [], "wall_type": 0}
]

func _set_level(value):
	level = value
	_generate_level()

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

func _get_subtile_coord(id):
	var selected_tile_set = room_walls.tile_set
	var rect = selected_tile_set.tile_get_region(id)
	var x = Globals.rng.randi() % int(rect.size.x / selected_tile_set.autotile_get_size(id).x)
	var y = Globals.rng.randi() % int(rect.size.y / selected_tile_set.autotile_get_size(id).y)
	return Vector2(x, y)

func _generate_level():
	room_walls = $Walls
	size = Vector2(6, 1)
	for node in get_children():
		if node != room_walls:
			node.queue_free()
	clear()
	room_walls.clear()
	var level_properties = level_props[level]
	var num_of_rooms = Globals.rng.randi_range(level_properties.min_num_of_rooms, level_properties.max_num_of_rooms)
	for i in range(num_of_rooms):
		size.y += 1
		var selected_room : TileMap = load("res://scenes/rooms/normal/R" + str(Globals.rng.randi_range(0, available_rooms)) + ".tscn").instance()
		for used_cell_position in selected_room.get_used_cells():
			var used_cell = selected_room.get_cellv(used_cell_position)
#			var entity_grid_position = Vector2(used_cell_position.x + 1, used_cell_position.y + size.y)
			if used_cell == 0:
				room_walls.set_cell(used_cell_position.x + 1, used_cell_position.y + size.y, level_properties.wall_type, false, false, false, _get_subtile_coord(level_properties.wall_type))
			elif used_cell == 1:
				var enemy_instance: Entity = level_properties.enemies[Globals.rng.randi_range(0, level_properties.enemies.size() - 1)].instance()
				enemy_instance.grid_position = Vector2(used_cell_position.x + 1, used_cell_position.y + size.y)
				add_child(enemy_instance)
		size.y += selected_room.length
	size.y += 1
	for x in size.x + 1:
		for y in size.y + 1:
			if x == 0 or y == 0 or x == size.x or y == size.y:
				set_cell(x, y, 0)
	update_bitmask_region(Vector2(0,0), size)
