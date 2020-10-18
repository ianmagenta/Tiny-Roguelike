extends Command
class_name Destroy

func _init(invoker: Node=null, receiver: Node=null).(invoker, receiver, "destroy"):
	pass

func execute():
	receiver.queue_free()
