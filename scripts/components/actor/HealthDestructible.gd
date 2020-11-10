extends NodeComponent
class_name HealthDestructible

func get_event_handlers():
	return ["space_entered"]

func space_entered(data: Dictionary):
	data.entity.emit_event("attack", {"target": parent})
