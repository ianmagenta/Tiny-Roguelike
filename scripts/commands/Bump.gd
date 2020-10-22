extends Command
class_name Bump

var target_position: Vector2

func _init(new_target_position):
	method = "bump"
	target_position = new_target_position
