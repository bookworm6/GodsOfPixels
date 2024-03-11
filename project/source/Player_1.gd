extends CharacterBody2D


const SPEED = 300.0
signal player1Dead


func _process(delta):
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("w"):
		rotation_degrees = 0
		velocity.y = -500
		
	elif Input.is_action_pressed("a"):
		rotation_degrees = 270
		velocity.x = -500
		velocity.y = 0
	elif Input.is_action_pressed("s"):
		rotation_degrees = 180
		velocity.y = 500
		velocity.x = 0
	elif Input.is_action_pressed("d"):
		rotation_degrees = 90
		velocity.x =500
		velocity.y = 0
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
	#print(rotation_degrees)

func bulletColision():
	player1Dead.emit()
	print("player dead")
	
	

	move_and_slide()