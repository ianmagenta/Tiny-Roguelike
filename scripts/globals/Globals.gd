tool
extends Node

var tile_size = 16
var dungeon_size: Vector2
var entity_group: Array
var player_group: Array
var ai_group: Array
var interact_group: Array
var rng = RandomNumberGenerator.new()

func refresh_entities():
	var tree = get_tree()
	entity_group = tree.get_nodes_in_group("Entity")
	player_group = tree.get_nodes_in_group("PC")
	ai_group = tree.get_nodes_in_group("AI")
	interact_group = tree.get_nodes_in_group("Interact")
