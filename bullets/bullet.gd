extends Area2D

const SPEED = 1000 #Speed of the Bullet
var direction = 1
var velocity = Vector2()



func _ready():
	pass

#Direction
func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$BulletSprite.flip_h = true
#Direction

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$BulletSprite.play()
	


func _on_BulletVisibility2D_screen_exited():
	queue_free()

func NO_Bullets():
	queue_free()

func Bullet_Sound_Effec():
	$Shoot_Sound_Effect.play()



func _on_Bullet_body_entered(body):
	if "Default_Enemy" in body.name:
		body.Enemy_Got_Damage() #Function Enemy will lose 50 life points
		body.Enemy_Dead()
		body.dead_enemy_add() #Add to body counter
		queue_free() #Bullets will disapear
