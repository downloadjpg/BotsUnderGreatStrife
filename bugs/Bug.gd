class_name Bug
extends KinematicBody2D

# General class for enemy movement and attack(s). Overriden by individual enemies.

signal died

export(int) var move_speed = 20
export(int) var health = 5 setget set_health
export(float) var iFramesInSeconds = 0.4
export(Script) var defaultBrain
export(Script) var playerBrain

var brain : Node

var explosionDeathScene = preload("res://bugs/components/ExplosionDeath.tscn")

var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
var look_at = Vector2.RIGHT
var invincible = false


func set_health(value):
	health = value
	if health <= 0:
		die()

func _ready():
	$Hurtbox.connect("area_entered", self, "_on_Hurtbox_area_entered")

func activate_as_ai():
	brain = Node.new()
	brain.set_script(defaultBrain)
	add_child(brain)
	add_to_group("Enemies")
	$BugSelector.queue_free()
	$AnimationPlayer.play("walk")
	
	var should_i_avoid_spikes = !$Hurtbox.get_collision_layer_bit(4)
	set_collision_mask_bit(4, true)
	set_collision_layer_bit(4, true)

func activate_as_player():
	$BugSounds/playerSelectSound.play()
	brain = Node.new()
	brain.set_script(playerBrain)
	add_child(brain)
	add_to_group("Player")
	$AnimationPlayer.play("walk")


func deactivate():
	if brain != null and !brain.is_queued_for_deletion():
		brain.queue_free()
		input_vector = Vector2.ZERO
		velocity = Vector2.ZERO
		set_physics_process(false) # stupid


func _physics_process(delta):
	velocity = input_vector * move_speed
	move_and_slide(velocity)
	if sign(velocity.x) != 0:
		$Sprite.scale.x = sign(velocity.x)

func hit(damage):
	if !invincible:
		set_health(health - damage)
		$DamageFlashPlayer.play("damage_flash")
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		camera.small_shake()
		invincible = true
		$BugSounds/hitSound.play()
		yield(get_tree().create_timer(iFramesInSeconds), "timeout")
		invincible = false
	

#func damage_flash():
#	var tween = Tween.new()
#	tween.interpolate_property(get_node("Sprite"), "modulate", Color(1,0.5,0.5,1), Color(1,1,1,1),  0.5)
#	tween.start()

func die():
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	camera.medium_shake()
	
	var explosion = explosionDeathScene.instance()
	get_tree().get_root().get_child(0).add_child(explosion)
	explosion.global_position = global_position
	
	emit_signal("died")
	remove_from_group("Bugs")
	queue_free()
	

func set_input_vector(vec: Vector2) -> void:
	input_vector = vec

func set_look_at(vec: Vector2) -> void:
	look_at = vec.normalized()

func action() -> void:
	pass
