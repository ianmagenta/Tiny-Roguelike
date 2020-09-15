extends Node

signal turn_loop_ended

var enemy_turn_timer = 0.5
var stop_turn_loop = false

onready var camera = $Camera2D

func start():
	pre_turn()

func pre_turn():
	Globals.refresh_entities()
	for entity in Globals.ai_group:
		entity.command(PreTurn.new())
#	yield(get_tree(), "idle_frame")
	player_turn()

func player_turn():
	if Globals.player_group:
		for entity in Globals.player_group:
			update_camera(entity)
			entity.command(StartTurn.new())
			yield(entity, "end_turn")
			update_camera(entity)
	else:
		yield(get_tree().create_timer(enemy_turn_timer), "timeout")
	if stop_turn_loop:
		stop_turn_loop = false
		emit_signal("turn_loop_ended")
	else:
		ai_turn()

func ai_turn():
	Globals.refresh_entities()
	for entity in Globals.ai_group:
		entity.command(StartTurn.new())
	pre_turn()

func stop():
	stop_turn_loop = true

func update_camera(entity):
	if camera.position.y != entity.position.y + Globals.tile_size/2:
		camera.position.y = entity.position.y + Globals.tile_size/2
