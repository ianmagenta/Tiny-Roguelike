extends Command
class_name EndTurn

func _init(invoker: Node, receiver: Node).(invoker, receiver, "end_turn"):
	pass

func execute(node: Object):
	if node.has_method("end_turn"):
		node.end_turn(self)
