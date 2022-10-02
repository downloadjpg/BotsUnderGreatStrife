extends EnemyBrain

var attackPosition : Vector2



func _physics_process(delta):
	body.set_input_vector((body.global_position - get_player_position()).normalized()) # away from player
	body.set_look_at(get_player_position() - body.global_position)
	body.action() # always be shootin
	
