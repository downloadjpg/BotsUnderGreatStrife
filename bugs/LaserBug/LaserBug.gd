extends Bug


var laser_scene = preload("res://bugs/LaserBug/Laser.tscn")


func action():
	# Get collision point
	$LaserRay.enabled = true
	var collision_point = $LaserRay.get_collision_point()
	var laser = laser_scene.instance()
	add_child(laser)
	laser.global_position = global_position
	laser.get_node("Tip").global_position = collision_point
	laser.get_node("Body").global_position = global_position + collision_point / 2
	laser.get_node("Body").rotation = global_position.angle_to_point(collision_point)
	laser.get_node("Body").scale.x = (collision_point -  global_position).length()
	

func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)



