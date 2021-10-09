extends Area2D

func _ready():
	pass 


func _on_Portal_Win_body_entered(body):
	if "Player" in body.name: 
		get_tree().change_scene("res://screens/Default_Win_Screen.tscn")
