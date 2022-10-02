extends Node2D

var velocity = Vector2.ZERO
var damage = 1

var excluded_bodies = [self]
var excluded_areas = []

func _physics_process(delta):
	position += velocity * delta


func _on_Hitbox_area_entered(area):
	if excluded_areas.find(area) == -1:
		area.get_parent().hit(damage)
		queue_free()


func _on_Hitbox_body_entered(body):
	print("body entered")
	if excluded_bodies.find(body) == -1:
		queue_free()


func _on_Area2D_body_entered(body):
	print("body entered")
	if excluded_bodies.find(body) == -1:
		queue_free()
