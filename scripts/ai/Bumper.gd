extends AiController

class_name Bumper

export var direction = Vector2(1, 0) setget _set_direction

var has_turn = false
var wall_bumps = 0

func start_turn():
	has_turn = true
	wall_bumps = 0
	shift()

func end_turn():
	has_turn = false

func _set_direction(value):
	direction = value
	if has_turn:
		if wall_bumps < 2:
			shift()
		else:
			parent.command(EndTurn.new())

func shift():
	parent.command(Move.new(direction))

func bump(_target_position):
	wall_bumps += 1
	self.direction *= -1
