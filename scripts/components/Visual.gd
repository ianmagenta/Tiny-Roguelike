tool
extends Sprite

class_name Visual

export var col = 1 setget _set_col
export var row = 0 setget _set_row

func _set_col(new_col):
	col = new_col
	if texture:
		texture.region = Rect2(col * Globals.tile_size, row * Globals.tile_size, Globals.tile_size, Globals.tile_size)

func _set_row(new_row):
	row = new_row
	if texture:
		texture.region = Rect2(col * Globals.tile_size, row * Globals.tile_size, Globals.tile_size, Globals.tile_size)

func _init(new_col: int=col, new_row: int=row, new_color: Color=self_modulate):
	col = new_col
	row = new_row
	if new_color == Color("#ffffff"):
		self_modulate = Color("#deeedc")
	else:
		self_modulate = new_color
	centered = false
	texture = AtlasTexture.new()
	texture.atlas = preload("res://resources/roguelike_sheet.png")
	texture.region = Rect2(col * Globals.tile_size, row * Globals.tile_size, Globals.tile_size, Globals.tile_size)
