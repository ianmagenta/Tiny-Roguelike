extends Command
class_name Move

var direction: Vector2

func _init(invoker: Node, receiver: Node, value: Vector2).(invoker, receiver, "move"):
	direction = value

func execute():
	var new_grid_position = receiver.grid_position + direction
	if _valid_move(new_grid_position):
		receiver.grid_position = new_grid_position
		receiver.prev_direction = direction

func _valid_move(new_grid_position: Vector2):
	var types = receiver.types
	for entity in Globals.entity_group:
		if !entity.is_queued_for_deletion() and entity.grid_position == new_grid_position:
			if entity.type == types.INTERACTABLE:
				Globals.process_command(Interact.new(receiver, entity))
			elif receiver.type == types.ENEMY and entity.type == types.ENEMY:
				Globals.process_command(Bump.new(entity, receiver, new_grid_position))
			else:
				Globals.process_command(Attack.new(entity, receiver, entity.grid_position - receiver.grid_position))
			return false
	return true
