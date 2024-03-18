extends Control

@onready var W = $W  # Assuming the button node is named "WButton"

func _process(delta):
	W.set_pressed(Input.is_action_pressed("w"))  # Check for the "w" key press
	if W.pressed:
		W.modulate = Color.LIGHT_BLUE  # Highlight when pressed
	else:
		W.modulate = Color.WHITE  # Reset color when not pressed



func _on_a_pressed():
	pass # Replace with function body.


func _on_s_pressed():
	pass # Replace with function body.


func _on_d_pressed():
	pass # Replace with function body.


func _on_w_pressed():
	pass # Replace with function body.
