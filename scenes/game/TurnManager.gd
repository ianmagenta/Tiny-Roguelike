extends Node

signal turn_loop_ended
signal player_updated(player)

var enemy_turn_timer = 0.5
var stop_turn_loop = false
var player_is_dead = false

onready var tree = get_tree()

func start():
	emit_signal("player_updated", Globals.current_pc)
	_start_turn_loop()

func _start_turn_loop():
	while true:
		Globals.refresh_entities()
		for entity in Globals.ai_group:
			Globals.process_command(entity, PreTurn.new())
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
		for entity in Globals.ai_group:
			Globals.process_command(entity, StartTurn.new())
			if player_is_dead:
				break
			Globals.process_command(entity, EndTurn.new())
		if player_is_dead:
			break
	stop_turn_loop = false
	player_is_dead = false
	emit_signal("turn_loop_ended")

func stop():
	stop_turn_loop = true
