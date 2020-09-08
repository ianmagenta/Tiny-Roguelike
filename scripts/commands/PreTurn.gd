class_name PreTurn

func execute(node: Object):
	if node.has_method("pre_turn"):
		node.pre_turn()
