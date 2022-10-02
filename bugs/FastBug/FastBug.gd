extends Bug

export(int) var range_offset = 5

var attack_scene = preload("res://bugs/bullets/Bullet.tscn")

func action():
	$BugSounds/fireSound.play()
	var attack = attack_scene.instance()
	attack.excluded_areas.append($Hurtbox)
	get_tree().current_scene.add_child(attack)

	attack.global_position = global_position + range_offset * look_at
	
	

func _physics_process(_delta):
	velocity = input_vector * move_speed
	velocity = move_and_slide(velocity)



 
