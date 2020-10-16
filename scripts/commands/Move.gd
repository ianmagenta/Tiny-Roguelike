extends Command
class_name Move

var direction: Vector2

func _init(invoker: Node, receiver: Node, value: Vector2).(invoker, receiver, "move"):
	direction = value

func execute(node: Object):
	if node.has_method("move"):
		node.move(self)
