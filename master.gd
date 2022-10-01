extends Node

onready var animationPlayer = $CanvasLayer/SceneTransitionRect/AnimationPlayer
onready var current_scene = $MainMenu

var sceneList = ["res://world.tscn", "res://world.tscn", "res://world.tscn", "res://menu/MainMenu.tscn"]

func change_scene(next_scene):
	animationPlayer.play("fade_in")
	yield(animationPlayer, "animation_finished")
	current_scene.queue_free()
	current_scene = load(next_scene).instance()
	add_child(current_scene)
	animationPlayer.play_backwards("fade_in")
