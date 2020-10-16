extends Node2D

class_name Entity

signal end_turn

var resource: Actor

var health: int
var damage: int
var num_commands = 0
var grid_position = Vector2(0, 0) setget _set_grid_position
var prev_direction = Vector2(0, 0)

onready var scene = get_parent()

func _set_grid_position(value: Vector2):
	grid_position = value
	position = Globals.grid_to_world(grid_position)

func _init(new_actor: Actor):
	add_to_group("Entity")
	resource = new_actor
	add_child(Visual.new(resource.texture, resource.color))
	if resource is Character:
		health = resource.health
		damage = resource.damage
	if resource is PlayerCharacter:
		add_child(PlayerController.new(self))
	elif resource is Enemy:
		add_child(AiController.new(self))
	elif resource is Interactable:
		add_child(InteractController.new(self))

func end_turn(_command: EndTurn):
	emit_signal("end_turn")

func destroy(_command: Destroy):
	Globals.message_log.add_message("A " + resource.name + " was killed...")
	queue_free()

func move(command: Move):
	var direction = command.direction
	var new_grid_position = grid_position + direction
	if _valid_move(new_grid_position):
		self.grid_position = new_grid_position
		prev_direction = direction
		Globals.process_command(EndTurn.new(self, self))

func _valid_move(new_grid_position: Vector2):
	for entity in Globals.entity_group:
		if entity and entity.grid_position == new_grid_position:
			if entity.is_in_group("Interact"):
				Globals.process_command(Interact.new(self, entity))
				Globals.process_command(EndTurn.new(self, self))
			elif is_in_group("AI") and entity.is_in_group("AI"):
				Globals.process_command(Bump.new(entity, self, new_grid_position))
			else:
				Globals.process_command(Attack.new(entity, self, entity.grid_position - grid_position))
				Globals.process_command(EndTurn.new(self, self))
			return false
	return true

func bump(_command: Bump):
#	scene.add_child(Shadow.new(Vector2(1, 0), $Visual.self_modulate, target_position, 1, 0.75))
	pass

func attack(command: Attack):
	command.damage += damage
	Globals.process_command(TakeDamage.new(self, command.invoker, command))

func take_damage(command: TakeDamage):
	var incoming_damage = command.attack_data.damage
	Globals.message_log.add_message(command.invoker.resource.name + " attacked " + command.receiver.resource.name + " for " + str(incoming_damage) + " damage.")	
	health -= incoming_damage
	if health <= 0:
		Globals.process_command(Destroy.new(command.invoker, command.receiver))

func queue_free():
	for group in get_groups():
		remove_from_group(group)
	.queue_free()
