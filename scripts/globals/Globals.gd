tool
extends Node

var tile_size = 16
var dungeon_size: Vector2
var dungeon_walls: Array
var entity_group: Array
var player_group: Array
var ai_group: Array
var interact_group: Array
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var current_pc: Entity = preload("res://scenes/entities/Knight.tscn").instance()

func refresh_entities():
	var tree = get_tree()
	entity_group = tree.get_nodes_in_group("Entity")
	player_group = tree.get_nodes_in_group("PC")
	ai_group = tree.get_nodes_in_group("AI")
	interact_group = tree.get_nodes_in_group("Interact")

func grid_to_world(grid_position : Vector2):
	return Vector2(grid_position.x * tile_size, grid_position.y * tile_size)

func space_is_wall(space : Vector2):
	if not (space in dungeon_walls) and space.x > 0 and space.x < dungeon_size.x and space.y > 0 and space.y < dungeon_size.y:
		return false
	return true

func space_is_interact(space : Vector2):
	for entity in get_tree().get_nodes_in_group("Interact"):
		if space == entity.grid_position:
			return true
	return false
