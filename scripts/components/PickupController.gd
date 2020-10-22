extends InteractController
class_name PickupController

func _init(parent).(parent):
	pass

func interact(command: Interact):
	Globals.process_command(command.interacting_entity, Pickup.new(command.receiver.resource))
