extends InteractController
class_name PickupController

func _init(parent).(parent):
	pass

func interact(command: Interact):
	Globals.message_log.add_message(command.interacting_entity.get_bbcode_name() + " picked up " + parent.get_bbcode_name(false) + ".")
	Globals.process_command(command.interacting_entity, Pickup.new(parent.resource))
	parent.queue_free()
