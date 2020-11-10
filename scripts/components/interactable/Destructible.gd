extends NodeComponent
class_name Destructible

export(int) var hits_to_destroy = 1 setget _set_hits_to_destroy

func _set_hits_to_destroy(new_hits):
	hits_to_destroy = new_hits
	if hits_to_destroy <= 0:
		parent.queue_free()

func get_event_handlers():
	return ["space_entered"]

func space_entered(_data):
	self.hits_to_destroy -= 1
	if hits_to_destroy == 0:
		Events.emit_signal("message_emitted", {})
