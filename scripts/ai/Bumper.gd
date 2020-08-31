extends Node

export var direction = Vector2(1, 0) setget _set_direction

var has_turn = false
var wall_bumps = 0

onready var parent = get_parent()

func _ready():
	Globals.emit_group(self, "AI")

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
