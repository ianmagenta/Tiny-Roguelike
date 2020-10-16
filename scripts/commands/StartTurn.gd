extends Command
class_name StartTurn

func _init(invoker: Node, receiver: Node).(invoker, receiver, "start_turn"):
	pass

func execute(node: Object):
	if node.has_method("start_turn"):
		node.start_turn(self)
