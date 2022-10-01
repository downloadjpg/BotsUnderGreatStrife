extends Node

func _ready():
	for node in get_tree().get_nodes_in_group("Bugs"):
		node.connect("died", self, "_on_bug_death")
		node.get_node("BugSelector").connect("bug_selected", self, "_on_bug_selected")
	

func _on_bug_selected(playerBug):
		playerBug.activate_as_player()
		playerBug.remove_from_group("Bugs") # quick trick to activate all enemies as ai
		get_tree().call_group("Bugs", "activate_as_ai")
		playerBug.add_to_group("Bugs")
		
		get_node("JUSTPICKONEBUG").queue_free()

func _on_bug_death():
	yield(get_tree().create_timer(0.3), "timeout")
	if get_tree().get_nodes_in_group("Enemies").size() == 0:
		change_level()
	elif get_tree().get_nodes_in_group("Player").size() == 0:
		game_over()




func change_level():
	get_tree().get_root().get_child(0).change_scene("res://menu/MainMenu.tscn")


func game_over():
	get_tree().get_root().get_child(0).change_scene("res://menu/MainMenu.tscn")
