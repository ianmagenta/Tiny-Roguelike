extends AiController

class_name Wanderer

var directions = []
var turn_action: Move
onready var pointer = Visual.new(Vector2(0,0), Color("#95928f"))

func _ready():
	._ready()
	yield(parent, "ready")
	parent.scene.add_child(pointer)
	pointer.z_index = 1

func pre_turn():
	directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
	find_valid_move()
	pointer.sprite = turn_action.direction + Vector2(29, 13)
	pointer.position = Globals.grid_to_world(parent.grid_position + turn_action.direction)

func start_turn():
	parent.command(turn_action)

func find_valid_move():
	while directions:
		var random_selection = Globals.rng.randi_range(0, directions.size() - 1)
		var move = directions[random_selection]
		if !Globals.space_is_wall(move + parent.grid_position):
			turn_action = Move.new(move)
			return
		else:
			directions.remove(random_selection)

func destroy():
	.destroy()
	pointer.queue_free()
