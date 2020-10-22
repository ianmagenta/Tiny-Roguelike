extends Controller

class_name AiController

var turn_action
var ai_code
var pointer: Pointer
var parent

func _init(new_parent):
	parent = new_parent
	pointer = Pointer.new(parent)
	parent.add_child(pointer)
	ai_code = parent.resource.behavior.new()

func pre_turn(command: PreTurn):
	turn_action = ai_code.execute(parent, command)
	pointer.update_action(turn_action)

func start_turn(_command: StartTurn):
	if turn_action:
		Globals.process_command(parent, turn_action)

func queue_free():
	pointer.queue_free()
	.queue_free()
