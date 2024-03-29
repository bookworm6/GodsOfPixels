extends CharacterBody2D

var firingVelocity
var targetPosition
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if targetPosition!=null:
		look_at(targetPosition)
	move_and_slide()

func setAreaBodyCollisionMask(maskNumber,status):
	$Area2D.set_collision_mask_value(maskNumber,status)
	



func fireAtTarget(startPositionVector,targetPositionVector):
	targetPosition = targetPositionVector
	position = startPositionVector
	var startPos = startPositionVector
	print("start position: "+str(startPos)+"    target position: "+str(targetPositionVector))
	var firingVelocity = (startPos.direction_to(targetPositionVector))*1000
	velocity = firingVelocity

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func bulletColision():
	pass


func _on_area_2d_body_entered(body):
	print(body.get_name())
	body.bulletColision()
	if body is StaticBody2D:
		queue_free()
	if body.is_in_group("enemy"):
		queue_free()


	
	

#
#
#func _on_area_2d_area_entered(area):
	#var parent = area.get_parent()
	#print(parent.get_name())
	#parent.bulletColision() 
