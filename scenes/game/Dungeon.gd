tool
extends Node2D

export var level = 0 setget _set_level

var available_rooms = -1
var available_player_rooms = -1
var available_exit_rooms = -1
var available_item_rooms = -1
var size = Vector2(6, 1)
var room_walls = TileMap.new()
var fake_walls = TileMap.new()
var level_props = [
	{"min_num_of_rooms": 3, "max_num_of_rooms": 5, "enemies": [preload("res://resources/enemies/Bat.tres")], "interactables": [], "wall_type": 0},
	{"min_num_of_rooms": 5, "max_num_of_rooms": 7, "enemies": [preload("res://resources/enemies/Bat.tres")], "interactables": [], "wall_type": 0},
	{"min_num_of_rooms": 7, "max_num_of_rooms": 9, "enemies": [preload("res://resources/enemies/Bat.tres")], "interactables": [], "wall_type": 0},
	{"min_num_of_rooms": 9, "max_num_of_rooms": 11, "enemies": [preload("res://resources/enemies/Bat.tres")], "interactables": [], "wall_type": 0},
	{"min_num_of_rooms": 11, "max_num_of_rooms": 13, "enemies": [preload("res://resources/enemies/Bat.tres")], "interactables": [], "wall_type": 0}
]
var dungeon_entities = [preload("res://scenes/entities/interactables/Exit.tscn"), preload("res://scenes/entities/interactables/Door.tscn")]

func _set_level(value):
	level = value
	_generate_level()

func _init():
	add_child(fake_walls)
	add_child(room_walls)
	fake_walls.cell_custom_transform = Transform2D(Vector2(16,0), Vector2(0,16), Vector2(0,0))
	room_walls.cell_custom_transform = Transform2D(Vector2(16,0), Vector2(0,16), Vector2(0,0))
	fake_walls.cell_size = Vector2(16,16)
	room_walls.cell_size = Vector2(16,16)
	fake_walls.tile_set = preload("res://resources/tilesets/wall_tileset.tres")
	room_walls.tile_set = preload("res://resources/tilesets/wall_tileset.tres")
	fake_walls.self_modulate = Color("57546f")
	room_walls.self_modulate = Color("57546f")
	# Checks the directory with rooms in them and counts them
	var dir = Directory.new()
	dir.open("res://scenes/rooms/normal")
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			available_rooms += 1
	# Checks the directory with player rooms in them and counts them
	dir.open("res://scenes/rooms/player")
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			available_player_rooms += 1
	# Checks the directory with exit rooms in them and counts them
	dir.open("res://scenes/rooms/exit")
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			available_exit_rooms += 1
	# Checks the directory with item rooms in them and counts them
	dir.open("res://scenes/rooms/item")
	dir.list_dir_begin(true, true)
	while true:
		var file = dir.get_next()
		if file == "":
			break
		else:
			available_item_rooms += 1

func _get_subtile_coord(id):
	var selected_tile_set = preload("res://resources/tilesets/wall_tileset.tres")
	var rect = selected_tile_set.tile_get_region(id)
	var x = Globals.rng.randi() % int(rect.size.x / selected_tile_set.autotile_get_size(id).x)
	var y = Globals.rng.randi() % int(rect.size.y / selected_tile_set.autotile_get_size(id).y)
	return Vector2(x, y)

func _generate_level():
	size = Vector2(6, 1)
	for node in get_children():
		if node != room_walls and node != Globals.current_pc and node != fake_walls:
			node.queue_free()
	room_walls.clear()
	fake_walls.clear()
	var level_properties = level_props[level]
	var num_of_rooms = Globals.rng.randi_range(level_properties.min_num_of_rooms, level_properties.max_num_of_rooms)
	var coin_flip = true if Globals.rng.randi_range(0, 1) == 1 else false
	for room_number in range(num_of_rooms):
		size.y += 1
		var selected_room: TileMap
		if room_number == 0:
			if coin_flip == true:
				selected_room = load("res://scenes/rooms/exit/E" + str(Globals.rng.randi_range(0, available_player_rooms)) + ".tscn").instance()
			else:
				selected_room = load("res://scenes/rooms/item/I" + str(Globals.rng.randi_range(0, available_item_rooms)) + ".tscn").instance()
		elif room_number == num_of_rooms - 1:
			if coin_flip == false:
				selected_room = load("res://scenes/rooms/exit/E" + str(Globals.rng.randi_range(0, available_player_rooms)) + ".tscn").instance()
			else:
				selected_room = load("res://scenes/rooms/item/I" + str(Globals.rng.randi_range(0, available_item_rooms)) + ".tscn").instance()
		elif room_number != floor(num_of_rooms / 2):
			selected_room = load("res://scenes/rooms/normal/R" + str(Globals.rng.randi_range(0, available_rooms)) + ".tscn").instance()
		else:
			selected_room = load("res://scenes/rooms/player/P" + str(Globals.rng.randi_range(0, available_player_rooms)) + ".tscn").instance()
		for used_cell_position in selected_room.get_used_cells():
			var used_cell = selected_room.get_cellv(used_cell_position)
			var entity_grid_position = Vector2(used_cell_position.x + 1, used_cell_position.y + size.y)
			if used_cell == 0:
				room_walls.set_cell(used_cell_position.x + 1, used_cell_position.y + size.y, level_properties.wall_type, false, false, false, _get_subtile_coord(level_properties.wall_type))
			elif used_cell == 1:
				var enemy_instance = Entity.new(level_properties.enemies[Globals.rng.randi_range(0, level_properties.enemies.size() - 1)])
				enemy_instance.grid_position = entity_grid_position
				add_child(enemy_instance)
			elif used_cell == 2:
				Globals.current_pc.grid_position = entity_grid_position
				if !is_a_parent_of(Globals.current_pc):
					add_child(Globals.current_pc)
			elif used_cell == 3:
				pass
			else:
				pass
#				var entity_instance = dungeon_entities[used_cell - 4]
#				entity_instance.grid_position = entity_grid_position
#				add_child(entity_instance)
		size.y += selected_room.length
	size.y += 1
	for x in range(1, size.x):
		for y in range(size.y, size.y + 11):
			fake_walls.set_cell(x, y, level_properties.wall_type, false, false, false, _get_subtile_coord(level_properties.wall_type))
		for y in range(0, -11, -1):
			fake_walls.set_cell(x, y, level_properties.wall_type, false, false, false, _get_subtile_coord(level_properties.wall_type))
	Globals.dungeon_size = size
	Globals.dungeon_walls = room_walls.get_used_cells()
