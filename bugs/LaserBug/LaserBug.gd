extends Bug


var laser_scene = preload("res://bugs/LaserBug/Laser.tscn")
var prefire_scene = preload("res://bugs/LaserBug/LaserPreFire.tscn")
var can_fire = true

export var laser_cooldown = 2.0


func action():
	
	if not can_fire:
		return
	else:
		can_fire = false
		
		# Get collision point
		$LaserRay.add_exception(self)
		$LaserRay.cast_to = look_at* 1000
		$LaserRay.enabled = true
		$LaserRay.force_raycast_update()
		var collision_point = $LaserRay.get_collision_point()
		print($LaserRay.get_collider())
		# Nab the rotation angle
		var theta = look_at.angle()
		
		
		# Create prefire laser
		var prefire = prefire_scene.instance()
		add_child(prefire)
		prefire.position = Vector2.ZERO
		prefire.global_rotation = theta
		var texture_width = 10
		prefire.scale.x = (collision_point - global_position).length() / texture_width
		print("scale")
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
		get_tree().current_scene.current_scene.add_child(laser)
		
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
		
		yield(get_tree().create_timer(laser_cooldown), "timeout")
		can_fire = true
	

func _physics_process(_delta):
	velocity = input_vector * move_speed
	velocity = move_and_slide(velocity)



