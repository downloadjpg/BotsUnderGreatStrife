extends Bug

export(float) var attack_cooldown = 1
export(float) var charge_speed = 35
export(float) var charge_duration = 2
export(int) var damage = 5

var state = ""

var can_attack = true
var charge_vector : Vector2

onready var hitbox = $Hitbox


func action():
	if can_attack:
		can_attack = false
		
		state = "windup"
		charge_vector = look_at
		$AnimationPlayer.play("windup")
		yield($AnimationPlayer, "animation_finished")
		$Sprite.frame = 2
		
		state = "charging"
		set_collision_mask_bit(2, false)
		set_collision_layer_bit(2, false)
		$Hurtbox.monitorable = false
		$Hitbox.monitoring = true
		$Sprite/ChargeSparks.visible = true
		$Sprite/ChargeSparks.frame = 0
		
		yield(get_tree().create_timer(charge_duration), "timeout")
		$Hurtbox.monitorable = true
		$Hitbox.monitoring = false
		set_collision_mask_bit(2, true)
		set_collision_layer_bit(2, true)
		state = "walking"
		$AnimationPlayer.play("walk")
		$Sprite/ChargeSparks.visible = false
		
		
		yield(get_tree().create_timer(attack_cooldown), "timeout")
		can_attack = true
	
	

func _physics_process(_delta):
	if state == "walking":
		velocity = input_vector * move_speed
		velocity = move_and_slide(velocity)
	elif state == "charging":
		velocity = charge_vector * charge_speed
		velocity = move_and_slide(velocity)
	elif state == "windup":
		pass


 


func _on_Hitbox_area_entered(area):
	area.get_parent().hit(damage)
