tool
extends SpriteComponent
class_name Render

func _init():
	if Engine.editor_hint:
		centered = false
		self_modulate = Color("f2f2f0")
		texture = AtlasTexture.new()
		texture.atlas = preload("res://resources/images/roguelike_sheet.png")
		texture.region = Rect2(Vector2(320,160), Vector2(16,16))
