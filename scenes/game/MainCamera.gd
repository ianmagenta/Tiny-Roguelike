extends Camera2D

var camera_view: Rect2 = Rect2(Vector2(position.x - 320, position.y - 184), Vector2(640,368))

func update_camera_position(player: Entity):
	position.y = player.position.y + Globals.tile_size / 2
	camera_view = Rect2(Vector2(position.x - 320, position.y - 200), Vector2(640,400))
