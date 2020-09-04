extends Visual

class_name Shadow

var decay_time: float
var tween = Tween.new()

func _init(col: int, row: int, color: Color, grid_position: Vector2, layer: int, transparency: float=0.25, new_decay_time: float=0.5).(col, row, color):
	position = Globals.grid_to_world(grid_position)
	z_index = layer
	decay_time = new_decay_time
	self_modulate.a = transparency
	add_child(tween)

func _ready():
	tween.interpolate_property(self, "self_modulate", self_modulate, Color(self_modulate.r, self_modulate.g, self_modulate.b, 0.0), decay_time)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()
