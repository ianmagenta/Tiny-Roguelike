extends Command
class_name Destroy

func _init(invoker: Node, receiver: Node).(invoker, receiver, "destroy"):
	pass

func execute():
	receiver.queue_free()
