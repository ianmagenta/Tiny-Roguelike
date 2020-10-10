var sight_line = []

func execute(ai_controller: AiController):
	var parent = ai_controller.parent
	var sight_radius_width = 4
	var sight_radius_height = 4
	var sight_radius = Rect2(parent.position - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height), Vector2(Globals.tile_size * (sight_radius_width * 2 + 1), Globals.tile_size * (sight_radius_height * 2 + 1)))
	if Globals.player_group:
		var player: Entity = Globals.player_group[0]
		var player_grid_position: Vector2 = player.grid_position
		var parent_grid_position: Vector2 = parent.grid_position
		if sight_radius.has_point(player.position):
			generate_sight_line(parent_grid_position, player_grid_position)
		if sight_line and parent_grid_position == sight_line[0]:
			sight_line.remove(0)
		if sight_line:
			var directions: Array
			if player.prev_direction.x:
				directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
			else:
				directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
			for direction in directions:
				var new_position = parent_grid_position + direction
				if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position) and sight_line[0].distance_to(new_position) < sight_line[0].distance_to(parent.grid_position):
					return Move.new(direction)
	return null

func generate_sight_line(start_vector: Vector2, end_vector: Vector2):
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
	
	points.remove(0)
	
	for point in points:
		if point in Globals.dungeon_walls or Globals.space_is_interact(point):
			return
	sight_line = points
