extends Node

func _ready():
	for node in get_tree().get_nodes_in_group("Bugs"):
		node.connect("died", self, "_on_bug_death")
	


func _on_bug_death():
	yield(get_tree().create_timer(0.3), "timeout")
	if get_tree().get_nodes_in_group("Enemies").size() == 0:
		change_level()
	elif get_tree().get_nodes_in_group("Player").size() == 0:
		game_over()




func change_level():
	print("ooooga booga i just changed the level")


func game_over():
	print("boohooo game over")
