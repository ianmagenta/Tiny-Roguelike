tool
extends Sprite

class_name Visual

export var sprite = Vector2(1, 0) setget _set_sprite

func _set_sprite(value: Vector2):
	sprite = value
	if texture:
		texture.region = Rect2(sprite.x * Globals.tile_size, sprite.y * Globals.tile_size, Globals.tile_size, Globals.tile_size)

func _init(new_sprite: Vector2=sprite, new_color: Color=self_modulate):
	sprite = new_sprite
	if new_color == Color("#ffffff"):
		self_modulate = Color("#f1f1ea")
	else:
		self_modulate = new_color
	centered = false
	texture = AtlasTexture.new()
	texture.atlas = preload("res://resources/roguelike_sheet.png")
	texture.region = Rect2(sprite.x * Globals.tile_size, sprite.y * Globals.tile_size, Globals.tile_size, Globals.tile_size)
