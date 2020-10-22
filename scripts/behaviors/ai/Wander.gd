func execute(parent, command: PreTurn):
	var directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
	randomize()
	directions.shuffle()
	for i in directions:
		var new_position = i + parent.grid_position
		if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position):
			return Move.new(i)
