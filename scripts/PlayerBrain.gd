extends Node

onready var body = get_child(0)


func get_player_input() -> Vector2:
	var vec = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		vec.y -= 1
	if Input.is_action_pressed("move_down"):
		vec.y += 1
	if Input.is_action_pressed("move_left"):
		vec.x -= 1
	if Input.is_action_pressed("move_right"):
		vec.x += 1
	return vec.normalized()


#func get_lookat_vector():
#	return ( - global_position()).normalized()

func _physics_process(delta):
	body.set_input_vector(get_player_input())
	#body.set_lookat_vector(get_lookat_vector())
	
	if Input.is_action_just_pressed("action"):
		body.action()
