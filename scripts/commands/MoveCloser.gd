extends Move
class_name MoveCloser

func _init(moving_entity: Node, target_entity: Node).():
	var directions: Array
	if target_entity.prev_direction.y:
		directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	else:
		directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
	for i in directions:
		var new_position = i + moving_entity.grid_position
		if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position) and \
		target_entity.grid_position.distance_to(new_position) < target_entity.grid_position.distance_to(moving_entity.grid_position):
			direction = i
			break
