extends NodeComponent
class_name NameTag

export var entity_name: String
export var article: String

func get_event_handlers():
	return ["get_name"]

func get_entity_name(data: Dictionary):
	pass
