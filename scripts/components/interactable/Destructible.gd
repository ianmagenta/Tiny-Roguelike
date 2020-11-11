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
		var entity_name = data.entity.get_bbcode_name()
		var parent_name = parent.get_bbcode_name(false)
		Events.emit_signal("message_emitted", str(entity_name.bbcode, " opened ", parent_name.bbcode, "."))
