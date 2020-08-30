extends Node2D

# Use this class to change out active scenes on-screen. Ex: Switch to main menu or game.

var game_sceen = preload("res://scenes/game/Game.tscn").instance()

func _init():
	VisualServer.set_default_clear_color(Color("#292929"))
	add_child(game_sceen)
	game_sceen.get_node("Dungeon").level += 1
	
