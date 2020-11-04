tool
extends Component
class_name NameTag

export(String) var name: String
export(String) var article: String
export(Array, Color) var colors: Array
export(String) var effect_name: String
export(Array, Array, String) var effect_variables: Array

func _init():
	resource_name = "NameTag"

func get_callback_list():
	return ["get_bbcode_name"]

func get_bbcode_name(data: Dictionary):
	if colors:
		var number_of_colors = colors.size()
		var letters_per_color = round(name.length() / number_of_colors)
		for i in number_of_colors:
			data["name"] += str("[color=#", colors[i].to_html(false), "]", name.substr(i * letters_per_color, letters_per_color), "[/color]")
	else:
		data["name"] += name
	if effect_name:
		var outer_effect_string = str("[", effect_name)
		for variable in effect_variables:
			outer_effect_string += str(" ", variable[0], "=", variable[1])
		outer_effect_string += "]"
		data["name"] = outer_effect_string + data["name"] + str("[", effect_name, "]")

#func get_raw_name
