extends Node

class_name PlayerController

var has_turn = false

onready var parent = get_parent()

func _ready():
	parent.add_to_group("PC")

func _unhandled_input(event):
	if has_turn:
		if event.is_action_pressed("ui_up"):
			parent.command(Move.new(Vector2(0, -1)))
		elif event.is_action_pressed("ui_right"):
			parent.command(Move.new(Vector2(1, 0)))
		elif event.is_action_pressed("ui_down"):
			parent.command(Move.new(Vector2(0, 1)))
		elif event.is_action_pressed("ui_left"):
			parent.command(Move.new(Vector2(-1, 0)))

func start_turn():
	has_turn = true

func end_turn():
	has_turn = false

func destroy():
	remove_from_group("PC")
	queue_free()
