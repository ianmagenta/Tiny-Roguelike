extends Interactable

class_name Openable

func interact(interacting_entity: Entity):
	parent.queue_free()
