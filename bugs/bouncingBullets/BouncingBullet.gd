extends Node2D

var max_collisions = 3

var velocity = Vector2.ZERO
var damage = 1

var count_collisions

var excluded_areas = []

func _on_Hitbox_area_entered(area):
	if excluded_areas.find(area) == -1:
		area.get_parent().hit(damage)
		queue_free()


func _on_Hitbox_body_entered(body):
	if count_collisions >= max_collisions:
		queue_free()
