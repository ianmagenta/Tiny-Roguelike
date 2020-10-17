extends Command
class_name EndTurn

func _init(invoker: Node, receiver: Node).(invoker, receiver, "end_turn"):
	pass

func execute():
	receiver.emit_signal("end_turn")
