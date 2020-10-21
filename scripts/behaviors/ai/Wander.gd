func execute(command: PreTurn):
	return MoveRandomly.new(command.invoker, command.receiver)
