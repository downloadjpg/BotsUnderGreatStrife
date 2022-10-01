extends Area2D

var excluded_areas = []
var excluded_bodies = []

export var damage = 3

func _on_Hitbox_area_entered(area):
	if excluded_areas.find(area) == -1:
		print("shit")
		area.get_parent().hit(damage)
