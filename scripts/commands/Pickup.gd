extends Command
class_name Pickup

var item_resource: Item

func _init(invoker: Node=null, receiver: Node=null, new_item_resource: Item=null).(invoker, receiver, "pickup"):
	item_resource = new_item_resource

func execute():
	Globals.message_log.add_message(receiver.get_bbcode_name() + " picked up " + invoker.get_bbcode_name(false) + ".")
	invoker.queue_free()
