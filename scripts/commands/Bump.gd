extends Command
class_name Bump

var target_position: Vector2

func _init(invoker: Node, receiver: Node, value: Vector2).(invoker, receiver, "bump"):
	target_position = value
