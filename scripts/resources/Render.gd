tool
extends Component
class_name Render

signal move_sprite(new_position)
signal free_sprite

export(AtlasTexture) var texture
export(Color) var color

func _init():
	resource_name = "Render"
	priority = -1

func added_to_entity(entity: Entity):
	var sprite = Visual.new(texture, color)
	connect("move_sprite", sprite, "set_position")
	connect("free_sprite", sprite, "queue_free")
	entity.add_child(sprite)

func removed_from_entity(_entity: Entity):
	emit_signal("free_sprite")

func get_callback_list():
	return ["moved"]

func moved(data: Dictionary):
	emit_signal("move_sprite", Globals.grid_to_world(data["grid_position"]))
