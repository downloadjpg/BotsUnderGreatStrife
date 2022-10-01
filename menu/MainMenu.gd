extends Node2D

export(String, FILE, "*.tscn") var next_scene


func _on_Button_pressed():
	get_tree().get_root().get_child(0).change_scene(next_scene)
