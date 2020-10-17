extends Command
class_name TakeDamage

var attack_data: Command

func _init(invoker: Node, receiver: Node, new_attack_data: Command).(invoker, receiver, "take_damage"):
	attack_data = new_attack_data

func execute():
	var incoming_damage = attack_data.damage
	receiver.health -= incoming_damage
	Globals.message_log.add_message(invoker.get_bbcode_name() + " dealt " + str(attack_data.damage) + " damage to " + receiver.get_bbcode_name(false) + ".")
	if receiver.health <= 0:
		Globals.process_command(Kill.new(invoker, receiver))
