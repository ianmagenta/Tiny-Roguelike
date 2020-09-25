extends Resource

class_name Enemy

export(String) var name
export(AtlasTexture) var texture
export(Color) var color = "f2f2f0"
export(int) var health = 1
export(int) var damage = 1
export(Array, Resource) var held_items
export(Resource) var behavior
