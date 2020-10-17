extends Node2D

class_name Entity

signal end_turn

enum types {PLAYER, ENEMY, INTERACTABLE}

export var resource: Resource setget _set_resource

var type: int setget _set_type
var health: int
var damage: int
var grid_position = Vector2(0, 0) setget _set_grid_position
var prev_direction = Vector2(0, 0)

func _set_resource(new_resource: Actor):
	resource = new_resource
	for node in get_children():
		node.queue_free()
	add_child(Visual.new(resource.texture, resource.color))
	if resource is Character:
		health = resource.health
		damage = resource.damage
	if resource is PlayerCharacter:
		add_child(PlayerController.new(self))
		type = types.PLAYER
	elif resource is Enemy:
		add_child(AiController.new(self))
		type = types.ENEMY
	elif resource is Interactable:
		add_child(InteractController.new(self))
		type = types.INTERACTABLE

func _set_type(new_type: int):
	type = new_type
	for node in get_children():
		if node is PlayerController or node is AiController or node is InteractController:
			node.queue_free()
	if type == types.PLAYER:
		add_child(PlayerController.new(self))
	elif type == types.ENEMY:
		add_child(AiController.new(self))
	elif type == types.INTERACTABLE:
		add_child(InteractController.new(self))

func _set_grid_position(value: Vector2):
	grid_position = value
	position = Globals.grid_to_world(grid_position)

func _init():
	add_to_group("Entity")

func queue_free():
	for group in get_groups():
		remove_from_group(group)
	.queue_free()

func get_bbcode_name(capitalize=true, color_data=true):
	if type != types.PLAYER:
		return resource.get_bbcode_name(capitalize, color_data)
	else:
		var new_name = "You"
		if color_data:
			new_name = "[color=#" + resource.color.to_html(false) + "]" + new_name + "[/color]"
		return new_name
