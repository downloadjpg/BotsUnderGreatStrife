extends TextureButton

export var amplitude = 0.1
export var frequency = 1.0

var time = 0.0

func _process(delta):
	time += delta
	rect_position.y += amplitude * sin(frequency * time)
