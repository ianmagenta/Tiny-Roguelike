extends Node2D

func fire_event(event):
	var signal_name = event.signal_name
	if has_user_signal(signal_name):
		emit_signal(signal_name)

func insert_component(component, high_priority=false):
	component.register(self)
	add_child(component)
	if !high_priority:
		move_child(component, 0)

func remove_component(component):
	component.un_register(self)
	remove_child(component)

func register_events(node, events: Array):
	for event in events:
		if !has_user_signal(event):
			add_user_signal(event, [{"name": "event", "type": TYPE_OBJECT}])
		connect(event, node, str("_on_", event, "_event"))

func un_register_events(node, events: Array):
	for event in events:
		disconnect(event.signal_name, node, str("_on_", event.signal_name, "_event"))

func register(parent):
	for node in get_children():
		node.un_register(self)
		node.register(parent)

func un_register(parent):
	for node in get_children():
		node.un_register(parent)
		node.register()
