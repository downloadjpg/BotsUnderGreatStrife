extends Node2D



func _on_Button_pressed():
	get_tree().get_root().get_child(0).change_scene("res://world.tscn")
