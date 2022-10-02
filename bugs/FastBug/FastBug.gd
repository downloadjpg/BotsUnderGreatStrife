extends Bug

export(float) var attack_cooldown = 0.4
export(int) var range_offset = 5

var attack_scene = preload("res://bugs/FastBug/FastAttack.tscn")
var can_attack = true

func action():
	if can_attack:
		can_attack = false
		$BugSounds/fireSound.play()
		var attack = attack_scene.instance()
		attack.excluded_areas.append($Hurtbox)
		get_tree().current_scene.current_scene.add_child(attack)

		attack.global_position = global_position + range_offset * look_at
		attack.global_rotation = look_at.angle()
		yield(get_tree().create_timer(attack_cooldown), "timeout")
		can_attack = true
	
	

func _physics_process(_delta):
	velocity = input_vector * move_speed
	velocity = move_and_slide(velocity)



 
