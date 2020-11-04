extends Sprite
class_name Visual

func _init(new_texture: AtlasTexture, color):
	texture = new_texture
	self_modulate = color
	centered = false
	name = "Visual"
