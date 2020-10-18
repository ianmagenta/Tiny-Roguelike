extends Command
class_name Attack

var damage = 0

func _init(invoker: Node=null, receiver: Node=null).(invoker, receiver, "attack"):
	pass

func execute():
	damage += receiver.damage
	Globals.process_command(TakeDamage.new(receiver, invoker, damage))
