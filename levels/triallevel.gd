extends Node2D

func _ready():
	if $"/root/HealthSystem".Default_Enemy == 1:
		get_tree().change_scene("res://screens/Default_Win_Screen.tscn")
