var player_sighted = false

func execute(command):
	if Globals.player_group:
		if !player_sighted and command.receiver.resource.has_los(command.receiver):
			player_sighted = true
		if player_sighted:
			return MoveCloser.new(Globals.current_pc, command.receiver)
	return null
