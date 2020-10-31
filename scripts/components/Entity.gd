extends Node
class_name Entity

func fire_event(signal_name, data):
	if !has_user_signal(signal_name):
		add_user_signal(signal_name, [{"name": "data", "type": TYPE_DICTIONARY}])
	emit_signal(signal_name, data)

func insert_component(component, high_priority=false):
	var signal_data = component.register()
	add_child(component)
	if !high_priority:
		move_child(component, 0)
	_register_callbacks(component, signal_data["callbacks"])
	_register_signals(component, signal_data["signals"])

func remove_component(component):
	component.un_register(self)
	remove_child(component)

func _register_callbacks(node, callbacks: Array):
	for callback in callbacks:
		if !has_user_signal(callback):
			add_user_signal(callback, [{"name": "data", "type": TYPE_DICTIONARY}])
		connect(callback, node, str("_on_", callback, "_event"))

func _register_signals(node: Node, signals: Array):
	for sgnl in signals:
		if !has_user_signal(sgnl):
			add_user_signal(sgnl, [{"name": "data", "type": TYPE_DICTIONARY}])
		node.connect(sgnl, self, "emit_signal")

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
