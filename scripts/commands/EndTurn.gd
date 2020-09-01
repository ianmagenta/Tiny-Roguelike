class_name EndTurn

func execute(node: Object):
	if node.has_method("end_turn"):
		node.end_turn()
