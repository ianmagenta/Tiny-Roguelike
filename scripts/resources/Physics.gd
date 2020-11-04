tool
extends Component
class_name Physics

var grid_position: Vector2 = Vector2(0,0) setget _set_grid_position
var prev_direction: Vector2 = Vector2(0,0)
var parent

func _init():
	resource_name = "Physics"
	priority = -1

func _set_grid_position(new_grid_position):
	Globals.entity_map.erase(grid_position)
	grid_position = new_grid_position
	Globals.entity_map[grid_position] = parent
	emit_event("moved", {"grid_position": new_grid_position})
	
func added_to_entity(entity):
	parent = entity

func move(data: Dictionary):
	var new_grid_position = grid_position + data.direction
	if !Globals.space_is_wall(new_grid_position):
		var entity_at_position = Globals.entity_map.get(new_grid_position)
		if entity_at_position:
			entity_at_position.emit_event("space_entered", {"entity": parent})
		else:
			self.grid_position = new_grid_position
			prev_direction = data.direction

func move_to(data: Dictionary):
	self.grid_position = data["grid_position"]

func get_callback_list():
	return ["move", "move_to"]
