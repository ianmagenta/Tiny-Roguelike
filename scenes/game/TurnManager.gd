extends Node

onready var camera = $Camera2D
var enemy_turn_timer = 0.5

func _ready():
	player_turn()

func player_turn():
	Globals.refresh_entities()
	if Globals.player_group:
		for entity in Globals.player_group:
			update_camera(entity)
			entity.command(StartTurn.new())
			yield(entity, "end_turn")
			update_camera(entity)
	else:
		yield(get_tree().create_timer(enemy_turn_timer), "timeout")
	ai_turn()

func ai_turn():
	Globals.refresh_entities()
	for entity in Globals.ai_group:
		entity.command(StartTurn.new())
	yield(get_tree(), "idle_frame")
	player_turn()

func update_camera(entity):
	if camera.position.y != entity.position.y:
		camera.position.y = entity.position.y
