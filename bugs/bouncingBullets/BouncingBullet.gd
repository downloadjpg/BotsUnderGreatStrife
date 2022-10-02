extends KinematicBody2D

var max_collisions = 4

var velocity = Vector2.ZERO
var damage = 2

var count_collisions = 0

var excluded_areas = []

func _on_Hitbox_area_entered(area):
	if excluded_areas.find(area) == -1:
		area.get_parent().hit(damage)
		queue_free()


func _physics_process(delta):
	move_and_slide(velocity)
	
	if get_slide_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			if count_collisions >= max_collisions:
				queue_free()
			else:
				count_collisions += 1
				velocity = velocity.bounce(collision.normal)
