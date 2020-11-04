extends ItemList

#func _ready():
#	Events.connect("item_picked_up", self, "_item_picked_up")
#
#func _item_picked_up(item_resource: Item):
#	add_icon_item(item_resource.texture)
#	var item_position = get_item_count() - 1
#	set_item_icon_modulate(item_position, item_resource.color)
#
#func _gui_input(event):
#	if event is InputEventMouseMotion:
#		if event.position.x < 176:
#			var item_number = get_item_at_position(event.position, true)
#			if item_number != -1:
#				select(item_number)
#				set_process_unhandled_input(true)
#			else:
#				unselect_all()
#			accept_event()
#		else:
#			unselect_all()
#
#func _unhandled_input(event):
#	if event is InputEventMouseMotion:
#		if is_anything_selected():
#			unselect_all()
#			set_process_unhandled_input(false)
