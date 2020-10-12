extends Node2D

# Use this class to change out active scenes on-screen. Ex: Switch to main menu or game.

var game_sceen = preload("res://scenes/game/Game.tscn").instance()

func _ready():
	get_tree().connect("screen_resized", self, "_screen_resized") # related to _screen_resized
	add_child(game_sceen)
	Globals.message_log = game_sceen.get_node("CanvasLayer/UI/MessageBox/Log")
	Globals.info_box = game_sceen.get_node("CanvasLayer/UI/MessageBox/Info")
	Globals.current_pc = Entity.new()
	Globals.current_pc.resource = preload("res://resources/player_characters/Knight.tres")
	game_sceen.get_node("Dungeon").level += 1
	Globals.message_log.add_message(Globals.current_pc.get_name() + " enter the Lurching Labyrinth...")
	game_sceen.get_node("TurnManager").start()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		OS.window_fullscreen = !OS.window_fullscreen
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _screen_resized():
	var viewport = get_viewport()
	var window_size = OS.get_window_size()

	# see how big the window is compared to the viewport size
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var scale_x = floor(window_size.x / viewport.size.x)
	var scale_y = floor(window_size.y / viewport.size.y)

	# use the smaller scale with 1x minimum scale
	var scale = max(1, min(scale_x, scale_y))

	# find the coordinate we will use to center the viewport inside the window
	var diff = window_size - (viewport.size * scale)
	var diffhalf = (diff * 0.5).floor()

	# attach the viewport to the rect we calculated
	viewport.set_attach_to_screen_rect(Rect2(diffhalf, viewport.size * scale))
