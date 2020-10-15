extends Camera2D

func _ready():
	get_node("../TurnManager").connect("player_updated", self, "_update_camera_position")

func _update_camera_position(player: Entity):
	position.y = player.position.y
