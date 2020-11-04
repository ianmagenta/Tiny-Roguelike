extends Camera2D

var camera_view: Rect2 = Rect2(Vector2(position.x - 320, position.y - 184), Vector2(640,368))

func _init():
	Events.connect("player_moved", self, "update_camera_position")

func update_camera_position(new_position: Vector2):
	position.y = new_position.y + Globals.tile_size / 2
	camera_view = Rect2(Vector2(position.x - 320, position.y - 200), Vector2(640,400))
