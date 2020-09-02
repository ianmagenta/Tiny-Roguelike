class_name Destroy

func execute(node: Object):
	if node.has_method("destroy"):
		node.destroy()
