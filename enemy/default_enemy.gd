extends KinematicBody2D
const Enemy_Stop = 0
const GRAVITY = 50 #Enemy Gravity
const FLOOR = Vector2(0,-1) #Floor Direction
var SPEED = 300 #Enemy MovementSpeed
const Zero_Life_Points = 0
var velocity = Vector2(0,0) #enemy velocity 
var direction = 1 #Enemy Direction
var is_dead = false #Function to check if enemy is dead
var enemylifepoints = 100 #Enemy Default Life Points
signal dead_enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = String(enemylifepoints)

func Enemy_Dead():
	if enemylifepoints == 0:
		is_dead = true
		$Label.text = String("0")
		emit_signal("dead_enemy")
		set_modulate(Color(1,0.3,0.3,0.4))
		velocity = Vector2(0,0)
		direction = Enemy_Stop
		SPEED = Enemy_Stop
		
		$Enemy_Color_Change.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		
		
	
		#Movments
		$EnemySprite.play("Enemy")
		#Moving to the right
		if direction ==1:
			$EnemySprite.flip_h = false
		else:
			$EnemySprite.flip_h = true
		#Flipping the Images
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR) #Moving
		
		#Movements
	
	#Wall Detection
	if is_on_wall():
		direction = direction * -1
	#Wall Detection
	
	


func _on_Side_Checker_Enemy_body_entered(body):
	body.getting_hurt_player(position.x)
	if "Player" in body.name:
		$"/root/HealthSystem".Player_Health -= 10
	


func Enemy_Got_Damage():
	enemylifepoints -=50
	$Label.text = String (enemylifepoints)
	$Enemy_Hurt.play()
	$Enemy_Color_Change.start()


func _on_Enemy_Color_Change_timeout():
	$EnemyCollision2D.disabled = true
	$Side_Checker_Enemy/Enemy_Side_Checker.disabled = true
	queue_free()
	

func dead_enemy_add():
	if enemylifepoints ==0:
		$"/root/HealthSystem".Default_Enemy += 1
func _on_Default_Enemy_dead_enemy():
	pass

func Enemy_Fall_Zone():
	queue_free()
