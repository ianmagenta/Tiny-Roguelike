extends Node2D

class_name Pointer

var action
var parent
var dont_clear = false

func _init(new_parent):
	z_index = 9
	parent = new_parent

func update_action(new_action):
	action = new_action
	update()

func end_turn(_command: EndTurn):
	if !dont_clear:
		action = null
		update()
	else:
		dont_clear = false

func attack(command: Attack):
	if command.target.is_in_group("Player"):
		dont_clear = true

func _draw():
	if action is Move:
		var direction = action.direction
		var atlas_texture = AtlasTexture.new()
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
