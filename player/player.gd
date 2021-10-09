extends KinematicBody2D

export var Max_Ammo = 30 #Total Ammo
var velocity = Vector2(0,0) #Direction of where characters go x & y Axis 
var on_ground = false #Detects if player is on a platform
var is_attacking = false #For Changing Animation When character attacks
const MOVEMENTSPEED = 500 #Movement Speed of player how fast a player can go 
const GRAVITY = 50 #Gravity of the game
const FLOOR = Vector2(0, -1) #Ground 
const JUMPFORCE = 1500 #The player's froce in Jumping
const BULLET = preload("res://bullets/Bullet.tscn")
const Empty_Ammo = 0 #Zero Bullets
const Default_Ammo = 30
func _ready():
	pass

func _physics_process(delta):
	#Right Movement
	if Input.is_action_pressed("right"):
		velocity.x = MOVEMENTSPEED
		$PlayerSprite.play("circle")
		$PlayerSprite.flip_h = false
		if sign ($AimingPosition.position.x) == -1:
			$AimingPosition.position.x *= -1
		
		
	#Moving Right 
	
	#Moving Left
	elif Input.is_action_pressed("left"):
		velocity.x = -MOVEMENTSPEED
		$PlayerSprite.play("circle")
		$PlayerSprite.flip_h = true
		if sign ($AimingPosition.position.x) == 1:
			$AimingPosition.position.x *= -1
	#Moving Left
	
	#Idle Function
	else:
		velocity.x = 0 #Makes the player stop moving if the left & right functions are released NOTE: Shoold be under the else not elif or if
		if on_ground == true && is_attacking == false:
			
			$PlayerSprite.play("circle")
			
	#Idle Function
	
	#On Floor
	if is_on_floor():
		if is_attacking == false:
			on_ground = true
		else:
			on_ground = false
	
	#Ammo Counter Text
	$HUD/Ammo_Counter.text = String(Max_Ammo)
	#Ammo Counter Text
	
	#Dead Enemy Counter
	$HUD/Enemy_Killed.text = String($"/root/HealthSystem".Default_Enemy)
	#Dead Enemy Counter
	
	#Player Health
	$HUD/Health.text = String($"/root/HealthSystem".Player_Health)
	
	#Jump Function
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = -JUMPFORCE
		on_ground = false
	#Jumpp Function
	
	#Shooting
	if Input.is_action_pressed("shoot")  && is_attacking == false:
		if is_on_floor():
			velocity.x = 0
		var bullet_instance = BULLET.instance()
		
		#Attacking 
		is_attacking = true
		$PlayerSprite.play("shooting")
		
		if sign ($AimingPosition.position.x) == 1:
			bullet_instance.set_bullet_direction(1)
		else:
			bullet_instance.set_bullet_direction(-1)
		
		#Ammo Counter
		
		Max_Ammo -=1
		if Max_Ammo < 1:
			bullet_instance.NO_Bullets()
			$Empty_No_Bullets.play()
			Max_Ammo = Empty_Ammo
			
			set_modulate(Color( 0.54, 0.17, 0.89, 1 ))
		get_parent().add_child(bullet_instance)
		bullet_instance.Bullet_Sound_Effec()
		#Ammo Counter
	
		bullet_instance.position = $AimingPosition.global_position
	#Reloading
	if Input.is_action_just_pressed("reload"):
		Max_Ammo = Default_Ammo	
		set_modulate( Color( 1, 0, 0, 1 ))
		$Reload_Sound_Effect.play()
	#Reloading
	
	#Moving Function
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity,FLOOR)
	#Moving Function
	
	#Game Over Function
	if $"/root/HealthSystem".Player_Health == 0:
		get_tree().change_scene("res://levels/TrialLevel.tscn")
	
func getting_hurt_player(var enemyposx):
	velocity.x = MOVEMENTSPEED * 0.500
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
	Input.action_release("left")
	Input.action_release("right")




func _on_PlayerSprite_animation_finished():
	is_attacking = false
