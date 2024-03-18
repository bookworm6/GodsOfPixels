extends Node
@onready var Character = $CharacterBody2D
@onready var shield = $StaticBody2D
var bulletBase = preload("res://source/Bullet.tscn")
var enemyScene = preload("res://source/enemy.tscn")
var spawnTimerStarted
var enemeySpawnList 
var down
var left
var right
var up
var spawnTimerUpperLimit
var spawnTimerLowerLimit
var random 


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.enemiesKilled = 0
	spawnTimerLowerLimit = 5
	spawnTimerUpperLimit = 10
	random = RandomNumberGenerator.new()
	spawnTimerStarted = false
	enemeySpawnList = []
	down = true;

func shoot():
	Character.get_node("BulletFireSound").play()
	var newBullet = bulletBase.instantiate()
	newBullet.set_position(Character.get_node("BulletOriginPoint").get_global_position())
	add_child(newBullet)
	newBullet.set_collision_mask_value(3,true)
	newBullet.setAreaBodyCollisionMask(3,true)
	newBullet.rotation_degrees = Character.rotation_degrees+90
	var newbulletrotation = 90 - abs(Character.rotation_degrees)
	var newBulletYvel = 1000*cos(Character.rotation)
	var newBulletXvel = 1000*sin(Character.rotation)
	newBullet.velocity = Vector2(newBulletXvel, -newBulletYvel)

func shield_move():
	
	if down == true:
		shield.position.x = Character.position.x
		shield.position.y = Character.position.y + 100
		shield.rotation_degrees = 180
	elif left == true:
		shield.position.x = Character.position.x - 100
		shield.position.y = Character.position.y
		shield.rotation_degrees = 270
	elif right == true:
		shield.position.x = Character.position.x + 100
		shield.position.y = Character.position.y
		shield.rotation_degrees = 90
	elif up == true:
		shield.position.x = Character.position.x
		shield.position.y = Character.position.y - 100
		shield.rotation_degrees = 0
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawnTimerStarted == false:
		$Timer.start(random.randf_range(spawnTimerLowerLimit,spawnTimerUpperLimit))
		spawnTimerStarted = true
	if Input.is_action_just_pressed("SPACEBAR"):
		shoot()
	for enemy in enemeySpawnList:
		if enemy!=null:
			enemy.setTargetPosition(Character.position)
	shield_move()
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		shieldcheck()
	if spawnTimerLowerLimit>.3:
		spawnTimerLowerLimit-.001
	if spawnTimerUpperLimit>1.5:
		spawnTimerUpperLimit-.001
	
func shieldcheck():
	if Input.is_action_just_pressed("ui_down"):
		down = true
	else:
		down = false
	if Input.is_action_just_pressed("ui_left"):
		left = true
	else:
		left = false
	if Input.is_action_just_pressed("ui_right"):
		right = true
	else:
		right = false
	if Input.is_action_just_pressed("ui_up"):
		up = true
	else:
		up = false


func _on_spawn_timer_timeout():
	spawnTimerStarted = false
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


func _on_background_music_finished():
	$BackgroundMusic.play()
