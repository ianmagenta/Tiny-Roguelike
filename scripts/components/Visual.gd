tool
extends Sprite

class_name Visual

export var col = 0 setget _set_col
export var row = 0 setget _set_row

var base_color = self_modulate

func _set_col(new_col):
	col = new_col
	if texture:
		texture.region = Rect2(col * Globals.tile_size, row * Globals.tile_size, Globals.tile_size, Globals.tile_size)

func _set_row(new_row):
	row = new_row
	if texture:
		texture.region = Rect2(col * Globals.tile_size, row * Globals.tile_size, Globals.tile_size, Globals.tile_size)

func _init():
	centered = false
	texture = AtlasTexture.new()
	texture.atlas = preload("res://resources/roguelike_sheet.png")
	texture.region = Rect2(col * Globals.tile_size, row * Globals.tile_size, Globals.tile_size, Globals.tile_size)
