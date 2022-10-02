extends Bug

export var bullet_spawn_speed = 10
export var bullet_spawn_spread_degrees = 5
export var bullet_fire_delay = 01.2

var bullet_scene = preload("res://bugs/bullets/Bullet.tscn")
var can_fire = true

func action():
	if can_fire:
		can_fire = false
		$BugSounds/fireSound.play()
		for n in range(1,3,1):
			var bullet = bullet_scene.instance()
			bullet.excluded_areas.append($Hurtbox)
			bullet.excluded_bodies.append(self)
			get_tree().current_scene.current_scene.add_child(bullet)
			bullet.velocity = look_at * (bullet_spawn_speed * n)
			bullet.velocity = bullet.velocity.rotated(deg2rad(randf() * bullet_spawn_spread_degrees))
			bullet.global_position = global_position +  bullet.velocity.normalized() * 20
		yield(get_tree().create_timer(bullet_fire_delay), "timeout")
		can_fire = true
	

func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)



 
