extends Bug


var laser_scene = preload("res://bugs/LaserBug/Laser.tscn")


func action():
	# Get collision point
	$BugSounds/laserSound.play()
	$LaserRay.cast_to = get_local_mouse_position() * 100
	$LaserRay.enabled = true
	$LaserRay.force_raycast_update()
	var collision_point = $LaserRay.get_collision_point()
	var laser = laser_scene.instance()
	laser.excluded_areas.append($Hurtbox)
	get_tree().get_root().get_child(0).add_child(laser)
	
	var theta = get_local_mouse_position().angle()
	laser.global_position = global_position
	laser.rotation = theta
	
	var tip = laser.get_node("Tip")
	var body = laser.get_node("Body")
	var base = laser.get_node("Base")
	
	tip.global_position = collision_point
	body.global_position = (tip.global_position + base.global_position) / 2
	body.scale.x = (tip.global_position - base.global_position).length() / body.texture.get_width()
	base.play()
	tip.play()
	yield(base, "animation_finished")
	
	laser.queue_free()
	

func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)



