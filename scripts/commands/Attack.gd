extends Command
class_name Attack

var damage = 0
var target

func _init(new_target: Node):
	method = "attack"
	target = new_target
