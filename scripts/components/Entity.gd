extends Node2D

class_name Entity

signal end_turn

export var resource: Resource setget _set_resource

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
		add_to_group("Player")
	elif resource is Enemy:
		add_to_group("AI")
	elif resource is Interactable:
		add_to_group("Interactable")
	elif resource is Item:
		add_to_group("Pickup")

func add_to_group(group_name, persistent=false):
	for group in get_groups():
		remove_from_group(group)
	for node in get_children():
		if node is PlayerController or node is AiController or node is InteractController or node is PickupController:
			node.queue_free()
	if group_name == "Player":
		add_child(PlayerController.new(self))
	elif group_name == "AI":
		add_child(AiController.new(self))
	elif group_name == "Interactable":
		add_child(InteractController.new(self))
	elif group_name == "Pickup":
		add_child(PickupController.new(self))
	.add_to_group(group_name, persistent)

func _set_grid_position(value: Vector2):
	Globals.entity_map.erase(grid_position)
	grid_position = value
	position = Globals.grid_to_world(grid_position)
	Globals.entity_map[grid_position] = self

func queue_free():
	Globals.entity_map.erase(grid_position)
	.queue_free()

func get_bbcode_name(capitalize=true, color_data=true):
	if !is_in_group("Player"):
		return resource.get_bbcode_name(capitalize, color_data)
	else:
		var new_name = "You"
		if color_data:
			new_name = "[color=#" + resource.color.to_html(false) + "]" + new_name + "[/color]"
		return new_name

func move(command: Move):
	var new_grid_position = grid_position + command.direction
	if _valid_move(new_grid_position):
		self.grid_position = new_grid_position
		prev_direction = command.direction

func _valid_move(new_grid_position: Vector2):
	var entity: Entity = Globals.entity_map.get(new_grid_position)
	if entity:
		if entity.is_in_group("Interactable"):
			Globals.process_command(entity, Interact.new(self))
		elif is_in_group("AI") and entity.is_in_group("AI"):
			Globals.process_command(self, Bump.new(new_grid_position))
		else:
			Globals.process_command(self, Attack.new(entity))
		return false
	return true

func end_turn(_command: EndTurn):
	if is_in_group("Player"):
		emit_signal("end_turn")
