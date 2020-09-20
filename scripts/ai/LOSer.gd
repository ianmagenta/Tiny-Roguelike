extends AiController

class_name LOSer

export var sight_radius_width = 4
export var sight_radius_height = 4

var directions = []
var sight_line = []
var turn_action: Move
var debug_color = false

onready var pointer = Visual.new(Vector2(0,0), Color("#95928f"))
onready var sight_radius = Rect2(parent.position - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height), Vector2(Globals.tile_size * (sight_radius_width * 2 + 1), Globals.tile_size * (sight_radius_height * 2 + 1)))

func _ready():
	._ready()
	yield(parent, "ready")
	parent.scene.add_child(pointer)
	pointer.z_index = 1

func _exit_tree():
	pointer.queue_free()

func pre_turn():
	debug_color = false
	turn_action = null
	if Globals.player_group:
		var player = Globals.player_group[0]
		var player_grid_position: Vector2 = player.grid_position
		var parent_grid_position: Vector2 = parent.grid_position
		if sight_radius.has_point(player.position):
			if has_los(parent_grid_position, player_grid_position):
				debug_color = true
		if sight_line.size() > 0 and parent_grid_position == sight_line[0]:
			sight_line.remove(0)
		if sight_line:
			var directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
			for direction in directions:
				var new_position = parent_grid_position + direction
				if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position) and sight_line[0].distance_to(new_position) < sight_line[0].distance_to(parent.grid_position):
					turn_action = Move.new(direction)
					pointer.sprite = direction + Vector2(29, 13)
					pointer.position = Globals.grid_to_world(parent_grid_position + turn_action.direction)
					sight_radius.position = (parent.position + direction * Globals.tile_size) - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height)
					update()
					return
		else:
			pointer.sprite = Vector2(0,0)
	else:
		pointer.sprite = Vector2(0,0)
	update()

func start_turn():
	if turn_action:
		parent.command(turn_action)

func has_los(start_vector: Vector2, end_vector: Vector2):
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
			return false
	sight_line = points
	return points

func _draw():
	var color = Color("ffffff")
	if debug_color:
		color = Color("bd515a")
	draw_rect(Rect2(position - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height), Vector2(Globals.tile_size * (sight_radius_width * 2 + 1), Globals.tile_size * (sight_radius_height * 2 + 1))) , color, false)
	if sight_line:
		draw_line(position + Vector2(8,8), (Globals.grid_to_world(sight_line[0]) - parent.position) + Vector2(8,8), color)
		for i in range(sight_line.size()):
			if i < sight_line.size() - 1:
				draw_line((Globals.grid_to_world(sight_line[i]) - parent.position) + Vector2(8,8), (Globals.grid_to_world(sight_line[i + 1]) - parent.position) + Vector2(8,8), color)
