extends Node
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
	newBullet.set_collision_mask_value(3,true)
	newBullet.setAreaBodyCollisionMask(3,true)
	newBullet.rotation_degrees = Character.rotation_degrees+90
	if Character.rotation_degrees == -180:
		newBullet.velocity = (Vector2(0, 1000))
	if Character.rotation_degrees == 0:
		newBullet.velocity = (Vector2(0, -1000))
	if Character.rotation_degrees == 90:
		newBullet.velocity = (Vector2(1000, 0))
	if Character.rotation_degrees == -90:
		newBullet.velocity = (Vector2(-1000, 0))

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawnTimerStarted == false:
		$Timer.start()
		spawnTimerStarted = true
	if Input.is_action_just_pressed("SPACEBAR"):
		shoot()
	for enemy in enemeySpawnList:
		enemy.setTargetPosition(Character.position)


func _on_spawn_timer_timeout():
	#spawnTimerStarted = false
	var newEnemy = enemyScene.instantiate()
	add_child(newEnemy)
	newEnemy.shoot.connect(_on_enemy_bullet_fired)
	print("shoot signal connected")
	enemeySpawnList.append(newEnemy)
	print(newEnemy.position)
	print("enemy spawned")


func _on_enemy_bullet_fired(position,targetPosition):
	print("targetPosition"+str(targetPosition))
	var bulletInstance = bulletBase.instantiate()
	add_child(bulletInstance)
	bulletInstance. set_collision_mask_value(2,true)
	bulletInstance.setAreaBodyCollisionMask(2,true)
	#bulletInstance.rotation_degrees = rotation_degrees+90
	bulletInstance.fireAtTarget(position,Character.position)


func _on_character_body_2d_player_1_dead():
	get_tree().change_scene_to_file("res://source/dead.tscn")
