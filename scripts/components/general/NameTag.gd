extends NodeComponent
class_name NameTag

export var entity_name: String
export var article: String

func get_event_handlers():
	return ["get_entity_name"]

func get_entity_name(data: Dictionary):
	if !data.get("entity_name"):
		data["entity_name"] = entity_name
		data["article"] = article
	else:
		data["tag_name"] = entity_name
		data["tag_article"] = article
