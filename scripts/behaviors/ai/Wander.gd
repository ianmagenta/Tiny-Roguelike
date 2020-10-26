extends AiBehavior

func execute(_command: PreTurn):
	return MoveRandomly.new(parent)
