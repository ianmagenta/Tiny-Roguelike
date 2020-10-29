extends Command
class_name LeaveLevel

var level_exit_source: Node

func _init(new_level_exit_source):
	method = "leave_level"
	level_exit_source = new_level_exit_source
