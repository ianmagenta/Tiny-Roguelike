var player_sighted = false

func execute(parent, command: PreTurn):
	var sight_resource = parent.resource
	if Globals.player_group:
		if !player_sighted and sight_resource.in_sight_radius(parent, Globals.current_pc) and Globals.aligned_with(parent, Globals.current_pc):
			player_sighted = true
		if player_sighted:
			return MoveCloser.new(Globals.current_pc)
	return null
