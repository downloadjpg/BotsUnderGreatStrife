extends Area2D

onready var myBug = get_parent()

signal bug_selected

func _on_BugSelector_input_event(viewport, event, shape_idx):
	# Selection is clicked
	if event.get_class() == "InputEventMouseButton" and event.pressed == true:
		yield(get_tree().create_timer(0.01), "timeout") # stupid hack to prevent player bug from attacking on the same frame they're selected
		emit_signal("bug_selected", myBug)
		queue_free()




func _on_BugSelector_mouse_entered():
	$AnimatedSprite.modulate = Color(1,1,1,1)



func _on_BugSelector_mouse_exited():
	$AnimatedSprite.modulate = Color(1,1,1,0.4)
