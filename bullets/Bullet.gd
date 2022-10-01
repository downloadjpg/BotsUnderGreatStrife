extends Node2D

var velocity = Vector2.ZERO
var damage = 1

func _physics_process(delta):
	position += velocity * delta


func _on_Hitbox_area_entered(area):
	queue_free()


func _on_Hitbox_body_entered(body):
	queue_free()
