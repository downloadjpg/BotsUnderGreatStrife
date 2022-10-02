extends Bug


var laser_scene = preload("res://bugs/LaserBug/Laser.tscn")
var prefire_scene = preload("res://bugs/LaserBug/LaserPreFire.tscn")

func action():
	
	# Get collision point
	$LaserRay.cast_to = get_local_mouse_position() * 100
	$LaserRay.enabled = true
	$LaserRay.force_raycast_update()
	var collision_point = $LaserRay.get_collision_point()
	# Nab the rotation angle
	var theta = get_local_mouse_position().angle()
	
	
	# Create prefire laser
	var prefire = prefire_scene.instance()
	add_child(prefire)
	prefire.global_position = global_position
	prefire.global_rotation = theta
	var texture_width = 3
	prefire.scale.x = (collision_point - global_position).length() / texture_width
	yield(prefire, "animation_finished")
	prefire.queue_free()
	
	# Laser firing -- -- - - -- 
	
	# Play sound!
	$BugSounds/laserSound.play()
	
	# Now that prefire is done, get the new cast to point (bug may have moved)
	$LaserRay.cast_to = Vector2.RIGHT.rotated(theta) * 1000 # same direction, not same endpoint
	$LaserRay.force_raycast_update()
	collision_point = $LaserRay.get_collision_point()
	# Create the laser
	var laser = laser_scene.instance()
	laser.excluded_areas.append($Hurtbox)
	get_tree().get_root().get_child(0).add_child(laser)
	
	# Update the laser's rotation and position, then go about moving
	# each individual part
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
	

func _physics_process(_delta):
	velocity = input_vector * move_speed
	velocity = move_and_slide(velocity)



