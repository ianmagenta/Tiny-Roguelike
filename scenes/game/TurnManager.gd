extends Node

signal turn_loop_ended
signal player_updated(player)

var enemy_turn_timer = 0.5
var stop_turn_loop = false
var player_is_dead = false
var ai_that_can_move = []

onready var tree = get_tree()
onready var camera: Camera2D = get_node("../MainCamera")

func start():
	emit_signal("player_updated", Globals.current_pc)
	_start_turn_loop()

func _start_turn_loop():
	while true:
		Globals.refresh_entities()
		ai_that_can_move.clear()
		for entity in Globals.ai_group:
			if camera.camera_view.has_point(entity.position):
				Globals.process_command(entity, PreTurn.new())
				ai_that_can_move.append(entity)
		yield(tree, "idle_frame")
		if Globals.player_group:
			var player: Entity = Globals.current_pc
			Globals.process_command(player, StartTurn.new())
			yield(player, "end_turn")
			emit_signal("player_updated", player)
			yield(tree, "idle_frame")
		else:
			yield(tree.create_timer(enemy_turn_timer), "timeout")
		if stop_turn_loop:
			break
		Globals.refresh_entities()
		for entity in ai_that_can_move:
			if entity and !entity.is_queued_for_deletion():
				if !player_is_dead:
					Globals.process_command(entity, StartTurn.new())
				Globals.process_command(entity, EndTurn.new())
		if player_is_dead:
			break
	stop_turn_loop = false
	player_is_dead = false
	emit_signal("turn_loop_ended")

func stop():
	stop_turn_loop = true
