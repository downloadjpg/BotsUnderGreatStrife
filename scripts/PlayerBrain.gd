extends Node

onready var body = get_parent()

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


func _physics_process(delta):
	body.set_input_vector(get_player_input())
	body.set_look_at((get_viewport().get_mouse_position() - body.global_position).normalized())
	
	if Input.is_action_just_pressed("action"):
		body.action()
