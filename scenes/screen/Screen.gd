extends Node2D

# Use this class to change out active scenes on-screen. Ex: Switch to main menu or game.

var game_sceen = preload("res://scenes/game/Game.tscn").instance()

func _ready():
	add_child(game_sceen)
	Globals.current_pc = preload("res://scenes/entities/player_characters/Knight.tscn").instance()
	Globals.message_log = game_sceen.get_node("InterfaceLayer/Interface/MessageFrame/Log")
	game_sceen.get_node("Dungeon").level += 1
	Globals.current_pc.emit_event("start_turn")
	
	Events.emit_signal("message_emitted", str(Globals.current_pc.get_bbcode_name().bbcode, " enter the Lurching Labrynth..."))
#	game_sceen.get_node("TurnManager").start()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		OS.window_fullscreen = !OS.window_fullscreen
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
#	elif event.is_action_pressed("ui_home", true):
#		Events.emit_signal("item_picked_up", preload("res://resources/items/RealSword.tres"))
