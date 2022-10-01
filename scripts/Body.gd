class_name Body
extends KinematicBody2D

# General class for enemy movement and attack(s). Overriden by individual enemies.

export(int) var move_speed = 20
export(int) var health = 5

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO

func set_input_vector(vec: Vector2) -> void:
	input_vector = vec

func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)

#func receive_movement(inp: Vector2) -> void:
#


func action() -> void:
	pass
