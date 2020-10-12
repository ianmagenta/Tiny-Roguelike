extends Sprite

var position_offset = Vector2(8,-4)
var bounding_box: Rect2

func _ready():
	var dungeon = get_node("../../Dungeon")
	bounding_box = Rect2(Vector2(dungeon.position.x,-Globals.tile_size), Vector2(112,376))

func _unhandled_input(event):
#	if event is InputEventMouseMotion:
#		var old_position = position
#		var grid_position = Globals.world_to_grid(event.position, position_offset)
#		var new_position = Globals.grid_to_world(grid_position, position_offset)
#		if old_position != new_position and bounding_box.has_point(new_position):
#			position = new_position
#			pass_along_info()
	if event.is_action_pressed("ui_up2"):
		move(Vector2(0,-1))
	elif event.is_action_pressed("ui_right2"):
		move(Vector2(1,0))
	elif event.is_action_pressed("ui_down2"):
		move(Vector2(0,1))
	elif event.is_action_pressed("ui_left2"):
		move(Vector2(-1,0))

func move(direction):
	var new_position = position + direction * Globals.tile_size
	if bounding_box.has_point(new_position):
		position = new_position
		pass_along_info()

func pass_along_info():
	yield(VisualServer, 'frame_pre_draw')
	for entity in Globals.entity_group:
		if entity.get_global_transform().origin + entity.get_canvas_transform().origin == get_global_transform().origin:
			Globals.info_box.display_info(entity)
			return
	Globals.info_box.display_info(null)
