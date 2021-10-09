extends Area2D
var Spawn_Enemy = preload("res://enemy/Default_Enemy.tscn")
func _ready():
	$Spwanner_Timer.start()



func _on_Spwanner_Timer_timeout():
	var Enter_Enemy = Spawn_Enemy.instance()
	add_child(Enter_Enemy)
	Enter_Enemy.position = $Spwanner_Collision.position
