func execute(ai_controller: AiController):
	var directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
	return find_valid_move(directions, ai_controller)

func find_valid_move(directions, ai_controller):
	while directions:
		randomize()
		directions.shuffle()
		var move = directions.pop_front()
		var parent = ai_controller.parent
		var new_position = move + parent.grid_position
		if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position):
			return Move.new(move)
	return null
