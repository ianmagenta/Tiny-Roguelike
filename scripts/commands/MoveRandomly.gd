extends Move
class_name MoveRandomly

var directions = [Vector2(1,0), Vector2(0,1), Vector2(-1,0), Vector2(0,-1)]
var cautious: bool

func _init(invoker: Node=null, receiver: Node=null, new_cautious=true).(invoker, receiver):
	cautious = new_cautious
	randomize()
	directions.shuffle()
	for i in directions:
		var new_position = i + receiver.grid_position
		if !Globals.space_is_wall(new_position):
			if !cautious:
				direction = i
			elif !Globals.space_is_interact(new_position):
				direction = i
