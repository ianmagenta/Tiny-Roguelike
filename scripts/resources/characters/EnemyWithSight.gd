extends Enemy

class_name EnemyWithSight

export(int) var sight_radius_width = 4
export(int) var sight_radius_height = 4

func in_sight_radius(entity, entity2):
	if Globals.player_group:
		var sight_radius = Rect2(entity.position - Vector2(Globals.tile_size * sight_radius_width, Globals.tile_size * sight_radius_height), Vector2(Globals.tile_size * (sight_radius_width * 2 + 1), Globals.tile_size * (sight_radius_height * 2 + 1)))
		if sight_radius.has_point(entity2.position):
			return true
		return false
