tool
extends RichTextEffect

class_name Typewriter

var bbcode = "type"

func _process_custom_fx(char_fx):
	var wait_time: float = char_fx.env.get("wait", 0.0)
	var speed: float = char_fx.env.get("speed", 32.0)
	var elapsed_time = char_fx.elapsed_time
	if elapsed_time > wait_time and float(elapsed_time) > ((float(char_fx.relative_index) / speed) + float(wait_time)):
		char_fx.visible = true
	else:
		char_fx.visible = false
	return true
