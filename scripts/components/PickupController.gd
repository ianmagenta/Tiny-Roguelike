extends Controller
#class_name PickupController
#
#var parent: Node
#
#func _init(new_parent):
#	parent = new_parent
#	name = "PickupController"
#
#func interact(command: Interact):
#	Globals.process_command(command.interacting_entity, Pickup.new(parent.resource))
#	if command.interacting_entity.is_in_group("player"):
#		Events.emit_signal("item_picked_up", parent.resource)
#	Globals.message_log.add_message(command.interacting_entity.get_bbcode_name() + " picked up " + parent.get_bbcode_name(false) + ".")
#	parent.queue_free()
