tool
extends Component
class_name Destructible

export(int) var hits_to_destroy = 1 setget _set_hits_to_destroy

func _set_hits_to_destroy(new_hits):
	hits_to_destroy = new_hits
	if hits_to_destroy <= 0:
		emit_signal("free_entity")

func _init():
	resource_name = "Destructible"
	resource_local_to_scene = true

func get_callback_list():
	return ["space_entered"]

func space_entered(data: Dictionary):
	self.hits_to_destroy -= 1
