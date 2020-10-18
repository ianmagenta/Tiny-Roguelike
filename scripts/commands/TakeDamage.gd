extends Command
class_name TakeDamage

export var damage = 0

func _init(invoker: Node=null, receiver: Node=null, new_damage=0).(invoker, receiver, "take_damage"):
	damage = new_damage

func execute():
	receiver.health -= damage
	Globals.message_log.add_message(invoker.get_bbcode_name() + " dealt " + str(damage) + " damage to " + receiver.get_bbcode_name(false) + ".")
	if receiver.health <= 0:
		Globals.process_command(Kill.new(invoker, receiver))
