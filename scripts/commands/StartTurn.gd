class_name StartTurn

func execute(node: Object):
	if node.has_method("start_turn"):
		node.start_turn()
