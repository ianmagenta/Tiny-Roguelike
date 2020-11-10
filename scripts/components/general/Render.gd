tool
extends SpriteComponent
class_name Render

func _init():
	if Engine.editor_hint and !texture:
		centered = false
		self_modulate = Color("f2f2f0")
		texture = AtlasTexture.new()
		texture.atlas = preload("res://resources/images/roguelike_sheet.png")
		texture.region = Rect2(Vector2(320,160), Vector2(16,16))

func get_event_handlers():
	return ["get_entity_name"]

func get_entity_name(data: Dictionary):
	data.color = self_modulate
