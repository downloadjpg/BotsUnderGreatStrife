class_name Body
extends KinematicBody2D

# General class for enemy movement and attack(s). Overriden by individual enemies.

export(int) var move_speed = 20
export(int) var health = 5 setget set_health 

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
var look_at = Vector2.RIGHT

func set_health(value):
	health = value
	if health <= 0:
		die()



func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)


func die():
	print(name + " has died")
	queue_free()

func set_input_vector(vec: Vector2) -> void:
	input_vector = vec

func set_look_at(vec: Vector2) -> void:
	look_at = vec

func action() -> void:
	pass
