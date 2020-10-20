func execute(command: PreTurn):
	Globals.message_log.add_message("Boogie woogie! This little batty watty likes to wiggle diggle its litte dittle butt as it flies! " + command.receiver.get_name())
	return MoveRandomly.new(command.invoker, command.receiver)
