extends Resource

class_name Actor

export(String) var name
export(String) var article
export(AtlasTexture) var texture
export(Color) var color = "f2f2f0"

func get_bbcode_name(capitalize=true, color_data=true):
	var new_name = name
	if color_data:
		new_name = "[color=#" + color.to_html(false) + "]" + new_name + "[/color]"
	new_name = article + " " + new_name
	if !capitalize:
		new_name[0] = new_name[0].to_lower()
	return new_name
