tool
extends Component
class_name PlayerController

signal set_has_turn(boolean)
signal free_player_controller

func _init():
	resource_name = "PlayerController"
	priority = -1

func added_to_entity(entity: Entity):
	var controller_node = PlayerControllerNode.new()
	connect("set_has_turn", controller_node, "_set_has_turn")
	connect("free_player_controller", controller_node, "queue_free")
	controller_node.connect("emit_event_to_resource", self, "emit_event")
	entity.add_child(controller_node)

func removed_from_entity(_entity: Entity):
	emit_signal("free_player_controller")

func start_turn(_data):
	emit_signal("set_has_turn", true)

func end_turn(_data):
	emit_signal("set_has_turn", false)

func moved(data: Dictionary):
	Events.emit_signal("player_moved", Globals.grid_to_world(data["grid_position"]))

func get_callback_list():
	return ["start_turn", "end_turn", "moved"]
