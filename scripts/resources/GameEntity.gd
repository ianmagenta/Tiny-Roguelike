tool
extends Resource
class_name GameEntity

export(int, "Player", "Interactable", "Enemy") var entity_type setget _set_entity_type
export(String) var scene_name = "NewEntity"
export(Array, Resource) var components setget _set_components
var file: File = File.new()
var dir: Directory = Directory.new()
var file_name: String = "player_characters"

func _set_entity_type(new_entity_type):
	if Engine.editor_hint:
		if !file.file_exists("res://scenes/entities/"):
			pass
	entity_type = new_entity_type
	if entity_type == 0:
		file_name = "player_characters"
	elif entity_type == 1:
		file_name = "interactables"
	elif entity_type == 2:
		file_name = "enemies"

func _set_components(new_components):
	components = new_components

func _notification(what):
	if what == NOTIFICATION_PREDELETE and Engine.editor_hint:
		print("deleted")
		var file_path = str("res://scenes/entities/", file_name)
		dir.open(file_path)
		dir.remove(str(file_path, "/", scene_name, ".tscn"))
	# not available in script >:(
	elif what == NOTIFICATION_POSTINITIALIZE and Engine.editor_hint:
		print("post init")
		var file_path = str("res://scenes/entities/", file_name, "/", scene_name, ".tscn")
		if Engine.editor_hint and !file.file_exists(file_path):
			print("write")
			file.open(file_path, File.WRITE)
			file.close()
