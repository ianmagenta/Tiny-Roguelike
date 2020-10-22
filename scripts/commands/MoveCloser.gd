extends Move
class_name MoveCloser

var target_entity: Node

func _init(new_target_entity: Node).():
	method = "move_closer"
	target_entity = new_target_entity
