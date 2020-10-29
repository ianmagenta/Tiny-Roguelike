extends Command
class_name TakeDamage

var source: Node
var damage = 0

func _init(new_source: Node, new_damage: int = 0):
	method = "take_damage"
	source = new_source
	damage = new_damage
