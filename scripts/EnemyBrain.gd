class_name EnemyBrain
extends Node

onready var body = get_parent()

func get_player_position() -> Vector2:
	if get_tree().get_nodes_in_group("Player").size() != 0:
		var player = get_tree().get_nodes_in_group("Player")[0]
		return player.global_position
	else:
		return Vector2(0,0)
