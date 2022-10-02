extends Node2D

export var damage = 2

var excluded_areas = []

func _on_Hitbox_area_entered(area):
	if excluded_areas.find(area) == -1:
		area.get_parent().hit(damage)
