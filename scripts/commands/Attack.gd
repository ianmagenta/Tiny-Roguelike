class_name Attack

var damage_data = {
	"target": null,
	"attack_vector": null,
	"damage": 0
}

func _init(new_target: Object, new_attack_vector: Vector2):
	damage_data.target = new_target
	damage_data.attack_vector = new_attack_vector

func execute(node: Object):
	if node.has_method("attack"):
		node.attack(damage_data)
