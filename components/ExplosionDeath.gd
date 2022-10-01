extends AnimatedSprite


func _ready():
	yield(self, "animation_finished")
	queue_free()
