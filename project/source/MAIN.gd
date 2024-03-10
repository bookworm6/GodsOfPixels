extends Node
@onready var bullet = $RigidBody2D
@onready var Character = $CharacterBody2D
var bulletBase = preload("res://source/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot():
	var newBullet = bulletBase.instantiate()
	newBullet.set_position(Character.position)
	add_child(newBullet)
	newBullet.gravity_scale = 0
	newBullet.rotation_degrees = Character.rotation_degrees
	if Character.rotation_degrees == -180:
		newBullet.set_linear_velocity(Vector2(0, 1000))
	if Character.rotation_degrees == 0:
		newBullet.set_linear_velocity(Vector2(0, -1000))
	if Character.rotation_degrees == 90:
		newBullet.set_linear_velocity(Vector2(1000, 0))
	if Character.rotation_degrees == -90:
		newBullet.set_linear_velocity(Vector2(-1000, 0))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("SPACEBAR"):
		shoot()
