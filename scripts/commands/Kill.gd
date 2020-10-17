extends Command
class_name Kill

func _init(invoker: Node, receiver: Node).(invoker, receiver, "kill"):
	pass

func execute():
	Globals.message_log.add_message(invoker.get_bbcode_name() + " killed " + receiver.get_bbcode_name(false) + "!")
	receiver.queue_free()
