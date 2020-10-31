tool
extends ResourceComponent
class_name RcEntity

export(Array, Resource) var components

func _init().():
	component = preload("res://scripts/components/Entity.gd")

func get_class():
	return "RcEntity"
