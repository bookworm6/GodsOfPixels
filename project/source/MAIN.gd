extends Node
@onready var bullet = $RigidBody2D
@onready var Character = $CharacterBody2D
var bulletBase = preload("res://source/Bullet.tscn")
var enemyScene = preload("res://source/enemy.tscn")
var spawnTimerStarted
var enemeySpawnList 


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnTimerStarted = false
	enemeySpawnList = []

func shoot():
	var newBullet = bulletBase.instantiate()
	newBullet.set_position(Character.position)
	add_child(newBullet)
	newBullet.gravity_scale = 0
	newBullet.rotation_degrees = Character.rotation_degrees+90
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
	if spawnTimerStarted == false:
		$Timer.start()
		spawnTimerStarted = true
	if Input.is_action_just_pressed("SPACEBAR"):
		shoot()
	for enemy in enemeySpawnList:
		enemy.setPlayer1Position(Character.position)


func _on_spawn_timer_timeout():
	#spawnTimerStarted = false
	var newEnemy = enemyScene.instantiate()
	add_child(newEnemy)
	enemeySpawnList.append(newEnemy)
	print(newEnemy.position)
	print("enemy spawned")

