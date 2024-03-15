extends CharacterBody2D


const SPEED = 300.0
signal player1Dead
var mousePos
var mouseX
var mouseY
var characterPos
var characterX
var characterY
var relativeMouseX
var relativeMouseY
func look():
	mousePos = get_viewport().get_mouse_position()
	mouseX = mousePos[0]
	mouseY = mousePos[1]
	characterPos = position
	characterX = characterPos[0]
	characterY = characterPos[1]
	#print(mouseX - characterX, "   ", mouseY - characterY)
	relativeMouseX = mouseX - characterX
	relativeMouseY = mouseY - characterY
	rotation = atan2(relativeMouseY,relativeMouseX)
	rotation_degrees += 90
	
func _process(delta):
	look()
	
	
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("w"):
		velocity.y = -500
		
	elif Input.is_action_pressed("a"):
		velocity.x = -500
		velocity.y = 0
	elif Input.is_action_pressed("s"):
		velocity.y = 500
		velocity.x = 0
	elif Input.is_action_pressed("d"):
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
