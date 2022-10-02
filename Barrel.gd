extends Node2D

onready var Explosion = preload("res://menu/Explosion.tscn")

func hit(damage):
	# spawn explosion
	var explosion = Explosion.instance()
	get_tree().current_scene.current_scene.add_child(explosion)
	explosion.global_position = global_position
	queue_free()
	
