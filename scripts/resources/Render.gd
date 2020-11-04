tool
extends Component
class_name Render

export(AtlasTexture) var texture
export(Color) var color
var sprite: Visual

func _init():
	resource_name = "Render"
	priority = -1

func added_to_entity(entity: Node):
	sprite = Visual.new(texture, color)
	entity.add_child(sprite)
