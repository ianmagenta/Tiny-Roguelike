tool
extends Resource
class_name ResourceComponent

var component: Script

func _init():
	resource_name = get_class()
