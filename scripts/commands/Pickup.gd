extends Command
class_name Pickup

var item_resource: Item

func _init(new_item_resource: Item):
	method = "pickup"
	item_resource = new_item_resource
