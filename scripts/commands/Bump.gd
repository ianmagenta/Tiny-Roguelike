class_name Bump

var target_position: Vector2

func _init(value: Vector2):
	target_position = value

func execute(node: Object):
	if node.has_method("bump"):
		node.bump(target_position)
