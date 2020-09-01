class_name Attack

var damage = 0
var target: Object
var attack_vector: Vector2

func _init(new_target: Object, new_attack_vector: Vector2):
	target = new_target
	attack_vector = new_attack_vector

func execute(node: Object):
	if node.has_method("attack"):
		node.attack(target, attack_vector, damage)
