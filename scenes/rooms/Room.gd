tool
extends TileMap

class_name Room

export var length = 5

func _init():
	cell_custom_transform = Transform2D(Vector2(16, 0), Vector2(0, 16), Vector2(0, 0))
	cell_size = Vector2(16, 16)
	self.tile_set = preload("res://scenes/rooms/room_tileset.tres")
