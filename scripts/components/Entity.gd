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
	name = resource.name
	for node in get_children():
		node.queue_free()
	add_child(Visual.new(resource.texture, resource.color))
	if resource is Character:
		health = resource.health
		damage = resource.damage
	if resource is PlayerCharacter:
		add_to_group("player")
	elif resource is Enemy:
		add_to_group("ai")
	elif resource is Interactable:
		add_to_group("interactable")
	elif resource is Item:
		add_to_group("pickup")

func add_to_group(group_name, persistent=false):
	if group_name == "player":
		add_child(PlayerController.new(self))
	elif group_name == "ai":
		add_child(AiController.new(self))
	elif group_name == "interactable":
		add_child(InteractController.new(self))
	elif group_name == "pickup":
		add_child(PickupController.new(self))
	.add_to_group(group_name, persistent)

func remove_from_group(group_name):
	if group_name == "player":
		var controller = get_node_or_null("PlayerController")
		if controller:
			controller.queue_free()
	elif group_name == "ai":
		var controller = get_node_or_null("AiController")
		if controller:
			controller.queue_free()
	elif group_name == "interactable":
		var controller = get_node_or_null("InteractController")
		if controller:
			controller.queue_free()
	elif group_name == "pickup":
		var controller = get_node_or_null("PickupController")
		if controller:
			controller.queue_free()
	.remove_from_group(group_name)

func _set_grid_position(value: Vector2):
	Globals.entity_map.erase(grid_position)
	grid_position = value
	position = Globals.grid_to_world(grid_position)
	Globals.entity_map[grid_position] = self

func queue_free():
	Globals.entity_map.erase(grid_position)
	for group in get_groups():
		remove_from_group(group)
	.queue_free()

func get_bbcode_name(capitalize=true, color_data=true):
	if !is_in_group("player"):
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
		if entity.is_in_group("interactable") or entity.is_in_group("pickup"):
			Globals.process_command(entity, Interact.new(self))
		elif is_in_group("ai") and entity.is_in_group("ai"):
			Globals.process_command(self, Bump.new(new_grid_position))
		else:
			Globals.process_command(self, Attack.new(entity))
		return false
	return true

func attack(command: Attack):
	command.damage += damage
	Globals.process_command(command.target, TakeDamage.new(self, command.damage))

func take_damage(command: TakeDamage):
	health -= command.damage
	Globals.message_log.add_message(command.source.get_bbcode_name() + " dealt " + str(command.damage) + " damage to " + get_bbcode_name(false) + ".")
	if health <= 0:
		Globals.process_command(self, Kill.new(command.source))

func kill(command: Kill):
	Globals.message_log.add_message(command.killing_entity.get_bbcode_name() + " killed " + get_bbcode_name(false) + "!")
	if !is_in_group("player"):
		queue_free()
	else:
		Globals.player_is_dead = true
		Globals.message_log.add_message("[shake rate=15 level=7][color=#bd515a]Game Over![/color][/shake]")

func end_turn(_command: EndTurn):
	if is_in_group("player"):
		emit_signal("end_turn")

func leave_level(command: LeaveLevel):
	var scene = get_parent()
	if is_in_group("player"):
		var turn_manager = scene.get_node("../TurnManager")
		turn_manager.stop()
		yield(turn_manager, "turn_loop_ended")
		scene.level += 1
		turn_manager.start()
	elif is_in_group("ai"):
		var next_level_enemies = scene.level_props[scene.level + 1].enemies
		var ai_scene = load(resource.filename)
		if !(ai_scene in next_level_enemies):
			next_level_enemies.append(ai_scene)
		queue_free()
	Globals.message_log.add_message(get_bbcode_name() + " descended " + command.level_exit_source.get_bbcode_name(false) + "...")

func pickup(command: Pickup):
	call_deferred("add_child", ItemController.new(command.item_resource))
