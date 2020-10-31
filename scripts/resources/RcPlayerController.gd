tool
extends ResourceComponent
class_name RcPlayerController

func _init().():
	component = preload("res://scripts/components/PlayerController.gd")

func get_class():
	return "RcPlayerController"
