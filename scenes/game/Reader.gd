extends Sprite

var position_offset = Vector2(8,-4)
var grid_position

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var old_position = position
		var grid_position = Globals.world_to_grid(event.position, position_offset)
		position = Globals.grid_to_world(grid_position, position_offset)
		if old_position != position:
			print("moved!", position)
			pass_along_info()

func pass_along_info():
	for entity in Globals.entity_group:
		if entity.get_global_transform().origin + entity.get_canvas_transform().origin == get_global_transform().origin:
			Globals.info_box.display_info(entity)
			return
	Globals.info_box.display_info(null)
