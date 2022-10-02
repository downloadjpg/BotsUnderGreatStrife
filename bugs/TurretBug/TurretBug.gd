extends Bug


var bullet_scene = preload("res://bugs/bouncingBullets/BouncingBullet.tscn")
var can_fire = true


export var fire_cooldown = 0.08
export var bullet_speed = 35


func action():
	
	if not can_fire:
		return
	else:
		can_fire = false
		
		# Play sound!
		$BugSounds/fireSound.play()
		
		var bullet = bullet_scene.instance()
		bullet.velocity = bullet_speed * look_at
		bullet.excluded_areas.append($Hurtbox)
		get_tree().current_scene.current_scene.add_child(bullet)

		bullet.global_position = global_position
		
		yield(get_tree().create_timer(fire_cooldown), "timeout")
		can_fire = true
	

func _physics_process(_delta):
	velocity = input_vector * move_speed
	velocity = move_and_slide(velocity)



