extends Command
class_name Attack

var attack_vector: Vector2
var damage = 0

func _init(invoker: Node, receiver: Node, new_attack_vector: Vector2).(invoker, receiver, "attack"):
	attack_vector = new_attack_vector

func execute():
	damage += receiver.damage
	Globals.process_command(TakeDamage.new(receiver, invoker, self))
