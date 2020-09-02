class_name TakeDamage

var damage_data: Dictionary

func _init(value: Dictionary):
	damage_data = value

func execute(node: Object):
	if node.has_method("take_damage"):
		node.take_damage(damage_data)
