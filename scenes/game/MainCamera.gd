extends Camera2D

var camera_view: Rect2 = Rect2(Vector2(position.x - 320, position.y - 184), Vector2(640,368))

func _ready():
	get_node("../TurnManager").connect("player_updated", self, "_update_camera_position")

func _update_camera_position(player: Entity):
	position.y = player.position.y + Globals.tile_size / 2
	camera_view = Rect2(Vector2(position.x - 320, position.y - 184), Vector2(640,368))
