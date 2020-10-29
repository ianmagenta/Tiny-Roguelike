extends Command
class_name Kill

var killing_entity: Node

func _init(new_killing_entity: Node):
	method = "kill"
	killing_entity = new_killing_entity
