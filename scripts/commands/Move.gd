class_name Move

var direction: Vector2

func _init(value: Vector2):
	direction = value

func execute(node: Object):
	if node.has_method("move"):
		node.move(direction)
