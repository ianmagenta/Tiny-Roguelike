class_name Interact

var interacting_entity

func _init(new_entity):
	interacting_entity = new_entity

func execute(node: Object):
	if node.has_method("interact"):
		node.interact(interacting_entity)
