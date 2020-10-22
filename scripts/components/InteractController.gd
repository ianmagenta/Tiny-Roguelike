extends Controller

class_name InteractController

var interact_code
var parent

func _init(new_parent):
	parent = new_parent
	interact_code = parent.resource.behavior.new()

func interact(command: Interact):
	interact_code.execute(parent, command)
