extends Sprite

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	position = get_global_mouse_position()
