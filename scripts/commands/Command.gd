class_name Command

var invoker: Node
var receiver: Node
var method: String

func _init(new_invoker: Node, new_receiver: Node, new_method: String):
	invoker = new_invoker
	receiver = new_receiver
	method = new_method

func execute():
	pass
