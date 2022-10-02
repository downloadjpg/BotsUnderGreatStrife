extends EnemyBrain

# START:
# Run towards player in straight line, update direction based on timer
# When in radius, try to attack.

export var time_between_moves = 2
export var attack_radius = 25

var attackPosition : Vector2
var moveDirection := Vector2.RIGHT
var moveTimer : Timer



func _ready():
	
	# CUSTOM STATS
	body.attack_cooldown *= 2
	
	moveTimer = Timer.new()
	moveTimer.autostart = true
	moveTimer.wait_time = time_between_moves
	add_child(moveTimer)
	moveTimer.connect("timeout", self, "_on_moveTimer_timeout")
	
	moveDirection = (get_player_position() - body.global_position).normalized()




func _physics_process(delta):
	body.set_input_vector(moveDirection)
	body.set_look_at(get_player_position() - body.global_position)
	
	if (get_player_position() - body.global_position).length() <= attack_radius:
		body.action()


func _on_moveTimer_timeout():
	moveDirection = (get_player_position() - body.global_position).normalized()	
