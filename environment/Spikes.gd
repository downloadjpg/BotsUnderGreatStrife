extends Node2D

export var damage = 1



func _on_Hitbox_area_entered(area):
	area.get_parent().hit(damage)
