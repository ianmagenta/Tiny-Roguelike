extends Node2D

class_name Entity

signal end_turn

enum types {PLAYER, ENEMY, INTERACTABLE}

export var resource: Resource setget _set_resource

var type = types.ENEMY setget _set_type
var health: int
var damage: int
var grid_position = Vector2(0, 0) setget _set_grid_position
var prev_direction = Vector2(0, 0)
var num_commands = 0
var signal_end_turn = false

func _set_resource(new_resource: Actor):
	resource = new_resource
	for node in get_children():
		node.queue_free()
	add_child(Visual.new(resource.texture, resource.color))
	if resource is Character:
		health = resource.health
		damage = resource.damage
	if resource is PlayerCharacter:
		add_child(PlayerController.new())
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
		add_child(PlayerController.new())
	elif type == types.ENEMY:
		add_child(AiController.new(self))
	elif type == types.INTERACTABLE:
		add_child(InteractController.new(self))

func _set_grid_position(value: Vector2):
	grid_position = value
	position = Globals.grid_to_world(grid_position)

func _init():
	add_to_group("Entity")

func get_name(capitalize=true, color_data=true):
	if type != types.PLAYER:
		return resource.get_bbcode_name(capitalize, color_data)
	else:
		var new_name = "You"
#		if !capitalize:
#			new_name[0] = new_name[0].to_lower()
		if color_data:
			new_name = "[color=#" + resource.color.to_html(false) + "]" + new_name + "[/color]"
		return new_name

func command(command):
	num_commands += 1
	var components = get_children()
	for component in components:
		command.execute(component)
	command.execute(self)
	num_commands -= 1
	if signal_end_turn and num_commands == 0:
		signal_end_turn = false
		emit_signal("end_turn")

func end_turn():
	signal_end_turn = true

func destroy():
	queue_free()

func move(direction):
	var new_grid_position = grid_position + direction
	if _valid_move(new_grid_position):
		self.grid_position = new_grid_position
		prev_direction = direction
	command(EndTurn.new())

func _valid_move(new_grid_position: Vector2):
	for entity in Globals.entity_group:
		if !entity.is_queued_for_deletion() and entity.grid_position == new_grid_position:
			if entity.type == types.INTERACTABLE:
				entity.command(Interact.new(self))
			elif type == types.ENEMY and entity.type == types.ENEMY:
				command(Bump.new(new_grid_position))
			else:
				command(Attack.new(entity, entity.grid_position - grid_position))
			return false
	return true

func attack(damage_data):
	damage_data.damage += damage
	damage_data.source = self
	damage_data.target.command(TakeDamage.new(damage_data))

func take_damage(damage_data):
	Globals.message_log.add_message(damage_data.source.get_name() + " attacked " + damage_data.target.get_name(false) + " for " + str(damage_data.damage) + " damage.")	
	health -= damage_data.damage
	if health <= 0:
		Globals.message_log.add_message(damage_data.source.get_name() + " killed " + damage_data.target.get_name(false) + "!")
		command(Destroy.new())

func queue_free():
	for group in get_groups():
		remove_from_group(group)
	.queue_free()
