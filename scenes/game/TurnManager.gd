extends Node

signal turn_loop_ended
signal player_updated(player)

var enemy_turn_timer = 0.5
var stop_turn_loop = false

func start():
	emit_signal("player_updated", Globals.current_pc)
	pre_turn()

func pre_turn():
	Globals.refresh_entities()
	for entity in Globals.ai_group:
		Globals.process_command(PreTurn.new(entity, entity))
	player_turn()

func player_turn():
	if Globals.player_group:
		var player: Entity = Globals.current_pc
		Globals.process_command(StartTurn.new(null, player))
		yield(player, "end_turn")
		emit_signal("player_updated", player)
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
		Globals.process_command(StartTurn.new(null, entity))
		Globals.process_command(EndTurn.new(null, entity))
	pre_turn()

func stop():
	stop_turn_loop = true
