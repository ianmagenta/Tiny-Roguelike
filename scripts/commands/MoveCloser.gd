extends Move
class_name MoveCloser

var directions: Array
var cautious = true

func _init(invoker: Node=null, receiver: Node=null, new_cautious=true).(invoker, receiver):
	cautious = new_cautious
	if invoker:
		if invoker.prev_direction.y:
			directions = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
		else:
			directions = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
		for i in directions:
			var new_position = i + receiver.grid_position
			if !Globals.space_is_wall(new_position) and invoker.grid_position.distance_to(new_position) < invoker.grid_position.distance_to(receiver.grid_position):
				if !cautious:
					direction = i
				elif !Globals.space_is_interact(new_position):
					direction = i
