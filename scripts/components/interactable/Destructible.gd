extends NodeComponent
class_name Destructible

export(int) var hits_to_destroy = 1 setget _set_hits_to_destroy

func _set_hits_to_destroy(new_hits):
	hits_to_destroy = new_hits
	if hits_to_destroy <= 0:
		parent.queue_free()

func get_event_handlers():
	return ["space_entered"]

func space_entered(data: Dictionary):
	self.hits_to_destroy -= 1
	if hits_to_destroy == 0:
		var entity_name = data.entity.bbcode_name
		var parent_name = parent.bbcode_name
		parent_name[0] = parent_name[0].to_lower()
		Events.emit_signal("message_emitted", str(entity_name, " opened ", parent_name, "."))
