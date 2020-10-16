extends Node2D

class_name Pointer

var action

func _init():
	z_index = 9

func update_action(new_action):
	action = new_action
	update()

func _draw():
	if action is Move:
		var direction = action.direction
		var atlas_texture = AtlasTexture.new()
		var parent = action.receiver
		var color: Color
		var texture_location
		if !Globals.space_is_player(parent.grid_position + direction):
			color = Color("b9b5c3")
			texture_location = direction + Vector2(29, 13)
		else:
			color = Color("bd515a")
			texture_location = direction + Vector2(29, 13)
		atlas_texture.atlas = preload("res://resources/images/roguelike_sheet.png")
		atlas_texture.region = Rect2(texture_location * Globals.tile_size, Vector2(16,16))
		draw_texture(atlas_texture, direction * Globals.tile_size, color)
