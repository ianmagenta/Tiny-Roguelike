extends Node2D

# Use this class to change out active scenes on-screen. Ex: Switch to main menu or game.

var game_sceen = preload("res://scenes/game/Game.tscn").instance()

func _ready():
	add_child(game_sceen)
	Globals.message_log = game_sceen.get_node("CanvasLayer/Log")
	game_sceen.get_node("Dungeon").level += 1
	game_sceen.get_node("TurnManager").start()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		OS.window_fullscreen = !OS.window_fullscreen
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
