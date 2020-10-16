class_name Command

var invoker: Node
var receiver: Node
var method: String

func _init(new_invoker, new_receiver: Object, new_method: String):
	invoker = new_invoker
	receiver = new_receiver
	method = new_method
