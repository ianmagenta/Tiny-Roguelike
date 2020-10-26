extends Controller
class_name AiBehavior

var turn_action

onready var parent = get_parent()
onready var pointer = parent.get_node("Pointer")

func pre_turn(command: PreTurn):
	turn_action = execute(command)
	pointer.update_action(turn_action)

func start_turn(_command: StartTurn):
	if turn_action:
		Globals.process_command(parent, turn_action)

func execute(_command: PreTurn):
	pass
