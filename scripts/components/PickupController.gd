extends InteractController
class_name PickupController

func _init(parent).(parent):
	pass

func interact(command: Interact):
	Globals.process_command(Pickup.new(command.receiver, command.invoker, command.receiver.resource))
