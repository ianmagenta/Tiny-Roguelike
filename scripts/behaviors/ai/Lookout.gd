extends AiBehavior

var target: Entity

func execute(command: PreTurn):
	var targets: Array
	if parent.is_in_group("player_ally"):
		targets = Globals.ai_that_can_move
	else:
		targets = Globals.ally_group + [Globals.current_pc]
	if !target or !(target in targets):
		var sight_resource = parent.resource
		for potential_target in targets:
			if sight_resource.in_sight_radius(parent, potential_target) and Globals.aligned_with(parent, potential_target):
				target = potential_target
				break
	if target:
		return MoveCloser.new(parent, target)
	return null
