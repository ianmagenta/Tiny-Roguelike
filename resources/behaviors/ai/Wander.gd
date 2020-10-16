func execute(parent: Node):
	var directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
	return find_valid_move(directions, parent)

func find_valid_move(directions, parent):
	while directions:
		randomize()
		directions.shuffle()
		var move = directions.pop_front()
		var new_position = move + parent.grid_position
		if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position):
			return Move.new(parent, parent, move)
	return null
