extends Command
class_name Interact

var interacting_entity

func _init(new_interacting_entity: Node):
	method = "interact"
	interacting_entity = new_interacting_entity
