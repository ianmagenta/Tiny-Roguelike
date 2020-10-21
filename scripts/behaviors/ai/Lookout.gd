var player_sighted = false

func execute(command: PreTurn):
	var sight_resource = command.receiver.resource
	if Globals.player_group:
		if !player_sighted and sight_resource.in_sight_radius(command.receiver, Globals.current_pc) and Globals.aligned_with(command.receiver, Globals.current_pc):
			player_sighted = true
		if player_sighted:
			return MoveCloser.new(Globals.current_pc, command.receiver)
	return null
