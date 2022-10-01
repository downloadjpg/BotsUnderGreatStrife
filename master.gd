extends Node

onready var animationPlayer = $CanvasLayer/SceneTransitionRect/AnimationPlayer

func change_scene():
	animationPlayer.play("fade_in")
	
