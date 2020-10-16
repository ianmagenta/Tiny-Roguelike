extends Command
class_name TakeDamage

var attack_data: Attack

func _init(invoker: Node, receiver: Node, new_attack_data: Attack).(invoker, receiver, "take_damage"):
	attack_data = new_attack_data

func execute(node: Object):
	if node.has_method("take_damage"):
		node.take_damage(self)
