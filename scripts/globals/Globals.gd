tool
extends Node

var tile_size = 16
var dungeon_size: Vector2
var dungeon_walls: TileMap
var player_group: Array
var ai_group: Array
var interact_group: Array
var ally_group: Array
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var current_pc = Entity.new()
var message_log: RichTextLabel
var entity_map = {}
var player_is_dead = false
var ai_that_can_move = []

func refresh_entities():
	var tree = get_tree()
	player_group = tree.get_nodes_in_group("player")
	ai_group = tree.get_nodes_in_group("ai")
	interact_group = tree.get_nodes_in_group("interactable")
	ally_group = tree.get_nodes_in_group("player_ally")

func grid_to_world(grid_position: Vector2):
	return Vector2(grid_position.x * tile_size, grid_position.y * tile_size)

func space_is_wall(space: Vector2):
	if dungeon_walls.get_cellv(space) != 0 and space.x > 0 and space.x < dungeon_size.x:
		return false
	return true

func space_is_interact(space: Vector2):
	var entity = entity_map.get(space)
	if entity and entity.is_in_group("interactable"):
		return true
	return false

func space_is_player(space: Vector2):
	var entity = entity_map.get(space)
	if entity and entity.is_in_group("player"):
		return true
	return false

func can_see(entity1, entity2):
	var start_vector = entity1.grid_position
	var end_vector = entity2.grid_position
	# Setup initial conditions
	var x1 = start_vector.x
	var y1 = start_vector.y
	var x2 = end_vector.x
	var y2 = end_vector.y
	var dx = x2 - x1
	var dy = y2 - y1
	# Determine how steep the line is
	var is_steep = abs(dy) > abs(dx)
	# Rotate line
	if is_steep:
		var temp: int
		temp = x1
		x1 = y1
		y1 = temp
		temp = x2
		x2 = y2
		y2 = temp
	# Swap start and end points if necessary and store swap state
	var swapped = false
	if x1 > x2:
		var temp: int
		temp = x1
		x1 = x2
		x2 = temp
		temp = y1
		y1 = y2
		y2 = temp
		swapped = true
	# Recalculate differentials
	dx = x2 - x1
	dy = y2 - y1
	
	# Calculate error
	var error = int(dx / 2.0)
	var ystep = 1 if y1 < y2 else -1
	
	# Iterate over bounding box generating points between start and end
	var y = y1
	var points: Array = []
	for x in range(x1, x2 + 1):
		var coord = Vector2(y, x) if is_steep else Vector2(x, y)
		points.append(coord)
		error -= abs(dy)
		if error < 0:
			y += ystep
			error += dx
	
	if swapped:
		points.invert()
	
	for point in points:
		if space_is_wall(point) or space_is_interact(point):
			return false
	return true

func aligned_with(entity1, entity2):
	var entity1_pos_x = entity1.grid_position.x
	var entity1_pos_y = entity1.grid_position.y
	var entity2_pos_x = entity2.grid_position.x
	var entity2_pos_y = entity2.grid_position.y
	if entity1_pos_x == entity2_pos_x:
		for i in range(entity1_pos_y, entity2_pos_y, entity1.grid_position.direction_to(entity2.grid_position).y):
			if space_is_wall(Vector2(entity1_pos_x,i)) or space_is_interact(Vector2(entity1_pos_x,i)):
				return false
		return true
	elif entity1_pos_y == entity2_pos_y:
		for i in range(entity1_pos_x, entity2_pos_x, entity1.grid_position.direction_to(entity2.grid_position).x):
			if space_is_wall(Vector2(i,entity1_pos_y)) or space_is_interact(Vector2(i,entity1_pos_y)):
				return false
		return true
	return false
