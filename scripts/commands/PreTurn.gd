extends Command
class_name PreTurn

func _init(invoker: Node, receiver: Node).(invoker, receiver, "pre_turn"):
	pass

func execute(node: Object):
	if node.has_method("pre_turn"):
		node.pre_turn(self)
