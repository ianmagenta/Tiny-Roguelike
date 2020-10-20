extends Enemy

class_name EnemyWithSight

export(int) var sight_radius_width = 4
export(int) var sight_radius_height = 4

func has_los(entity):
	if Globals.player_group:
		var sight_radius = Rect2(entity.position - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height), Vector2(Globals.tile_size * (sight_radius_width * 2 + 1), Globals.tile_size * (sight_radius_height * 2 + 1)))
		if sight_radius.has_point(Globals.current_pc.position) and _has_sight_line(entity):
			return true
		return false

func _has_sight_line(entity):
	var entity_pos_x = entity.grid_position.x
	var entity_pos_y = entity.grid_position.y
	var player_pos_x = Globals.current_pc.grid_position.x
	var player_pos_y = Globals.current_pc.grid_position.y
	if entity_pos_x == player_pos_x:
		for i in range(entity_pos_y, player_pos_y, entity.grid_position.direction_to(Globals.current_pc.grid_position).y):
			if Globals.space_is_wall(Vector2(entity_pos_x,i)) or Globals.space_is_interact(Vector2(entity_pos_x,i)):
				return false
		return true
	elif entity_pos_y == player_pos_y:
		for i in range(entity_pos_x, player_pos_x, entity.grid_position.direction_to(Globals.current_pc.grid_position).x):
			if Globals.space_is_wall(Vector2(i,entity_pos_y)) or Globals.space_is_interact(Vector2(i,entity_pos_y)):
				return false
		return true
	return false
