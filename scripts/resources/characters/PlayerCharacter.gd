extends Character

class_name PlayerCharacter

func get_bbcode_name(capitalize=true, color_data=true):
	var new_name = name
	if color_data:
		new_name = "[color=#" + color.to_html(false) + "]" + new_name + "[/color]"
	new_name = article + " " + new_name
	if !capitalize:
		new_name[0] = new_name[0].to_lower()
	return new_name

func get_fp_bbcode_name(capitalize=true, color_data=true):
	var new_name = "You"
	if !capitalize:
		new_name[0] = new_name[0].to_lower()
	if color_data:
		new_name = "[color=#" + color.to_html(false) + "]" + new_name + "[/color]"
	return new_name
