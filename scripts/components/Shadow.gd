extends Visual

class_name Shadow

var decay_time = 0.25
var tween = Tween.new()

func _init(col: int, row: int, color: Color, grid_position: Vector2, layer: int).(col, row, color):
	position = Globals.grid_to_world(grid_position)
	z_index = layer
	self_modulate.a = 0.1
	add_child(tween)

func _ready():
	tween.interpolate_property(self, "self_modulate", self_modulate, Color(self_modulate.r, self_modulate.g, self_modulate.b, 0.0), decay_time)
	tween.start()
	yield(tween, "tween_completed")
	queue_free()
