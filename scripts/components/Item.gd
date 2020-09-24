extends Interactable

class_name Item

func interact(interacting_entity: Entity):
	parent.queue_free()
	interacting_entity.add_child(self)
