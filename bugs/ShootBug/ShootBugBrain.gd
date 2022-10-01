extends Node


var viewRadius = 15

#func _ready():
#	var viewzone = Area2D.new()
#	add_child(viewzone)
#	var viewzoneCollider = CollisionShape2D.new()
#	viewzone.add_child(viewzoneCollider)
#	var shape = CircleShape2D.new()
#	shape.radius = viewRadius
#	viewzoneCollider.shape = shape
#	viewzone.connect("body_entered", self, "_on_body_entered_viewzone")



var attackPosition : Vector2
var wanderDirection : Vector2
var moveTimer : Timer

func _ready():
	moveTimer = Timer.new()
	moveTimer.autostart = true
	add_child(moveTimer)
	moveTimer.connect("timeout", self, "_on_moveTimer_timeout")



func _physics_process(delta):
	var body = get_parent()
	print(moveTimer.time_left)
	body.set_input_vector(wanderDirection)

func _on_moveTimer_timeout():
	var phi = rand_range(0, 2 * PI)
	wanderDirection = Vector2(sin(phi), cos(phi))
