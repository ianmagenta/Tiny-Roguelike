extends Command
class_name Interact

var interacting_entity

func _init(invoker: Node, receiver: Node).(invoker, receiver, "interact"):
	pass

func execute(node: Object):
	if node.has_method("interact"):
		node.interact(self)
