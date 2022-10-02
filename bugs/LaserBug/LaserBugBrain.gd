extends EnemyBrain

export var time_between_moves = 1

var attackPosition : Vector2
var wanderDirection : Vector2
var moveTimer : Timer

func _ready():
	moveTimer = Timer.new()
	moveTimer.wait_time = time_between_moves
	moveTimer.autostart = true
	add_child(moveTimer)
	moveTimer.connect("timeout", self, "_on_moveTimer_timeout")



func _physics_process(delta):
	body = get_parent()
	body.set_input_vector(wanderDirection)
	body.set_look_at(get_player_position() - body.global_position)

func _on_moveTimer_timeout():
	var phi = rand_range(0, 2 * PI)
	wanderDirection = Vector2(sin(phi), cos(phi))
	body.action()
