extends CharacterBody2D

var goalPosition
var shootTimerStarted
var targetPosition
var random 
var bulletScene
var viewportWidth
var viewportHeight
var speed
var hasEnteredPlayingArea
signal shoot(startPosition,targetPosition)
var currentlyExploding


func _ready():
	$EnemySpaceship.show() #this line should not be necessary, but it might fix the problem with GitHub
	currentlyExploding = false
	random = RandomNumberGenerator.new()
	$AnimatedSprite2D.hide()
	targetPosition = Vector2.ZERO
	hasEnteredPlayingArea = false
	speed = 500
	shootTimerStarted = false
	bulletScene = load("res://source/Bullet.tscn")
	var startSide = random.randi_range(1,4)
	viewportWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
	viewportHeight = ProjectSettings.get_setting("display/window/size/viewport_height")
	if startSide == 1: #comes in from the left
		position.x = -10
		position.y = random.randf_range(-10,viewportHeight+10)
		#print("start left")
		goalPosition = Vector2(viewportWidth,random.randf_range(0,viewportHeight))
	elif startSide == 3: #comes in from the right
		position.x = viewportWidth+10
		position.y = random.randf_range(-10,viewportHeight+10)
		goalPosition = Vector2(0,random.randf_range(0,viewportHeight))
		#print("start right")
	elif startSide == 2: # comes in from top
		position.y = -10
		position.x = random.randf_range(-10,viewportWidth+10)
		goalPosition = Vector2(random.randf_range(0,viewportWidth),viewportHeight)
		#print("start top")
	elif startSide == 4: #comes in from bottom
		position.y = viewportHeight+10
		position.x = random.randf_range(-10,viewportWidth+10)
		goalPosition  = Vector2(random.randf_range(0,viewportWidth),0)
		#print("start bottom")
	velocity = position.direction_to(goalPosition)*speed


func _physics_process(delta):
	if targetPosition!=Vector2.ZERO:
		look_at(targetPosition)
		if shootTimerStarted == false:
			$Timer.start(random.randf_range(1,5 ))
			shootTimerStarted = true
	if hasEnteredPlayingArea==false:
		if 0<position.x and viewportWidth>position.x and 0<position.y and viewportHeight>position.y:
			hasEnteredPlayingArea=true
			#print("has entered playing area")
	if hasEnteredPlayingArea == true:
		if velocity.length()<300 and currentlyExploding == false:
			print ("enemy slow velocity: "+str(velocity.length()))
			print("test")
			var goalVelocity = velocity
			goalVelocity = goalVelocity.normalized()*(speed*-1)
			print("new goal velocity: "+str(goalVelocity.length()))
			velocity = goalVelocity
			print("new velocity: "+str(velocity.length()))
			#var goalPositionDirection = random.randi_range(1,4)
			#if goalPositionDirection == 1:
				#goalPosition = Vector2(random.randf_range(0,viewportWidth),viewportHeight)
			#elif goalPositionDirection == 2:
				#goalPosition  = Vector2(random.randf_range(0,viewportWidth),0)
			#elif goalPositionDirection ==3:
				#goalPosition = Vector2(viewportWidth,random.randf_range(0,viewportHeight))
			#elif goalPositionDirection ==4:
				#goalPosition = Vector2(0,random.randf_range(0,viewportHeight))
			#velocity = position.direction_to(goalPosition)*speed
			
		if position.y<=0:
			goalPosition = Vector2(random.randf_range(0,viewportWidth),viewportHeight)
			#print("position:" +str(position))
			#print("too high")
			velocity = position.direction_to(goalPosition)*speed
			hasEnteredPlayingArea=false
			#print("has left playing area")
		elif position.y>=viewportHeight:
			goalPosition  = Vector2(random.randf_range(0,viewportWidth),0)
			velocity = position.direction_to(goalPosition)*speed
			#print("position:" +str(position))
			#print("too low")
			hasEnteredPlayingArea=false
			#print("has left playing area")
		elif position.x<0:
			goalPosition = Vector2(viewportWidth,random.randf_range(0,viewportHeight))
			velocity = position.direction_to(goalPosition)*speed
			#print("position:" +str(position))
			#print("too left")
			hasEnteredPlayingArea=false
			#print("has left playing area")
		elif position.x>viewportWidth:
			goalPosition = Vector2(0,random.randf_range(0,viewportHeight))
			velocity = position.direction_to(goalPosition)*speed
			#print("position:" +str(position))
			#print("too right")
			hasEnteredPlayingArea=false
			#print("has left playing area")
	#print("position:" +str(position))
	#print("velocity" + str(velocity))
	#print("goal position: "+str(goalPosition))
		
	move_and_slide()
	

func _on_shoot_timer_timeout():
	#shoot.emit(position,targetPosition)
	shoot.emit($BulletOriginPoint.get_global_position(),targetPosition)
	shootTimerStarted = false

func setTargetPosition(vector2Position):
	targetPosition = vector2Position

func bulletColision():
	if currentlyExploding == false:
		currentlyExploding = true
		Global.enemiesKilled+=1
		velocity = Vector2.ZERO
		$Timer.stop()
		print("animation will play here")
		velocity = Vector2.ZERO
		$AnimatedSprite2D.show()
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("explode")
		$EnemySpaceship.hide()
		#$AnimationPlayer.play("hit")
	

	
	
	#$MeshInstance2D.hide()
	#$MeshInstance2D2.hide()
	#queue_free()


	



func _on_animated_sprite_2d_animation_finished():
	queue_free()
