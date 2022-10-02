extends AnimatedSprite




func _on_Explosion_animation_finished():
	queue_free()


func _on_Hitbox_area_entered(area):
	area.get_parent().hit(5000)
