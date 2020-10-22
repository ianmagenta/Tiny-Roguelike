extends Command
class_name TakeDamage

export var damage = 0

func _init(new_damage: int = 0):
	method = "take_damage"
	damage = new_damage
