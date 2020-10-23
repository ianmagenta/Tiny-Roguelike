extends Sprite

class_name Visual

onready var parent = get_parent()

func _init(new_texture: AtlasTexture, color):
	texture = new_texture
	self_modulate = color
	centered = false

func kill(_command: Kill):
	if parent.is_in_group("Player"):
		texture.region = Rect2(Vector2(12 * Globals.tile_size, 8 * Globals.tile_size),Vector2(Globals.tile_size, Globals.tile_size))
