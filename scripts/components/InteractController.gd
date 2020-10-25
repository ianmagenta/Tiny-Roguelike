extends Controller

class_name InteractController

func _init(parent):
	name = "InteractController"
	set_script(parent.resource.behavior)
