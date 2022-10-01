extends Area2D

onready var myBug = get_parent()

func _on_BugSelector_input_event(viewport, event, shape_idx):
	if event.get_class() == "InputEventMouseButton" and event.pressed == true:
		myBug.activate_as_player()
		myBug.remove_from_group("Bugs")
		get_tree().call_group("Bugs", "activate_as_ai")
		myBug.add_to_group("Bugs")
		queue_free()

		
