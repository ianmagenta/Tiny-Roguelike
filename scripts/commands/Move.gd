extends Command
class_name Move

export var direction: Vector2

func _init(new_direction: Vector2 = Vector2(0,0)):
	method = "move"
	direction = new_direction
