extends Interactables

class_name Openable

func interact(_interacting_entity: Entity):
	parent.queue_free()
