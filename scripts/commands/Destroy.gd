extends Command
class_name Destroy

func _init(invoker: Node, receiver: Node).(invoker, receiver, "destroy"):
	pass

func execute(node: Object):
	if node.has_method("destroy"):
		node.destroy(self)
