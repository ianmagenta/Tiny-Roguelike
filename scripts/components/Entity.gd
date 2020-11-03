extends Node
class_name Entity

var _components: Array = []

func insert_component(component: Component):
	_register_callbacks(component)
	_register_signals(component)
	_components.append(component)

func remove_component(component):
	_un_register_component(component)
	_components.erase(component)

func _register_callbacks(component: Component):
	var callbacks = component.get_callback_list()
	for callback in callbacks:
		if !has_user_signal(callback):
			add_user_signal(callback, [{"name": "data", "type": TYPE_DICTIONARY}])
		connect(callback, component, str("_on_", callback, "_event"))

func _register_signals(component: Component):
	var signals = component.get_signal_list()
	for sgnl in signals:
		if !has_user_signal(sgnl):
			add_user_signal(sgnl, [{"name": "data", "type": TYPE_DICTIONARY}])
		component.connect(sgnl, self, "emit_signal")

func _un_register_component(component: Component):
	for callback in component.get_callback_list():
		disconnect(callback, component, str("_on_", callback, "_event"))
	for sgnl in component.get_signal_list():
		component.disconnect(sgnl, self, "emit_signal")
