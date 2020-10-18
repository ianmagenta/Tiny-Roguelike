extends Command
class_name Bump

export var target_position: Vector2

func _init(invoker: Node=null, receiver: Node=null, new_target_position: Vector2=Vector2(0,0)).(invoker, receiver, "bump"):
	target_position = new_target_position
