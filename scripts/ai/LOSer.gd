extends AiController

class_name LOSer

export var sight_radius_width = 5
export var sight_radius_height = 5

var directions = []
var turn_action: Move
var sight_radius = Rect2(parent.grid_position - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height), Vector2(Globals.tile_size * (sight_radius_width * 2 + 1), Globals.tile_size * (sight_radius_height * 2 + 1)))
var target: Entity

onready var pointer = Visual.new(Vector2(0,0), Color("#95928f"))

func _ready():
	._ready()
	yield(parent, "ready")
	parent.scene.add_child(pointer)
	pointer.z_index = 1

func pre_turn():
#	for entity in group(PC)
	directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
	find_valid_move()
	pointer.sprite = turn_action.direction + Vector2(29, 13)
	pointer.position = Globals.grid_to_world(parent.grid_position + turn_action.direction)

func start_turn():
	parent.command(turn_action)

func find_valid_move():
	while directions:
		randomize()
		directions.shuffle()
		var move = directions.pop_front()
		var new_position = move + parent.grid_position
		if !Globals.space_is_wall(new_position) and !Globals.space_is_interact(new_position):
			turn_action = Move.new(move)
			return

func _exit_tree():
	pointer.queue_free()
