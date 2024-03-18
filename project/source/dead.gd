extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.enemiesKilled>Global.highScore:
		Global.highScore = Global.enemiesKilled
	$aliensKilled.text = ("aliens killed: "+str(Global.enemiesKilled))
	$HighScore.text = ("high score: "+str(Global.highScore))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://source/main.tscn")
