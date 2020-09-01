extends Node2D

# Use this class to change out active scenes on-screen. Ex: Switch to main menu or game.

var game_sceen = preload("res://scenes/game/Game.tscn").instance()

func _ready():
	add_child(game_sceen)
	Globals.current_pc = preload("res://scenes/entities/Knight.tscn").instance()
	game_sceen.get_node("Dungeon").level += 1
	game_sceen.get_node("TurnManager").start()
