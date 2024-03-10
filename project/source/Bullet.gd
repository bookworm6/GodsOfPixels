extends RigidBody2D

var firingVelocity
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func fireAtTarget(startPositionVector,targetPositionVector):
	var startPos = startPositionVector
	var firingVelocity = startPos.direction_to(targetPositionVector)*1000
	set_linear_velocity(firingVelocity)
	
