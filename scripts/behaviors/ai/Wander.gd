extends AiBehavior

func execute(command: PreTurn):
	return MoveRandomly.new(parent)
