extends Node2D

var velocity = Vector2.ZERO
var damage = 1

var excluded_bodies = []
var excluded_areas = []

func _physics_process(delta):
	position += velocity * delta


func _on_Hitbox_area_entered(area):
	if excluded_areas.find(area) == -1:
		queue_free()
		area.get_parent().hit(damage)


func _on_Hitbox_body_entered(body):
	if excluded_bodies.find(body) == -1:
		queue_free()
