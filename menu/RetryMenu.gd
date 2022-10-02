extends Control

signal restart
signal next_level


func _on_Retry_pressed():
	emit_signal("restart")


func _on_NextLevel_pressed():
	emit_signal("next_level")
