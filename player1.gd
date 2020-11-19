extends KinematicBody2D

#by irungu_developer

var player1Velocity = Vector2(0,0) 
var jump_count = 0
const MAX_JUMP_COUNT = 1
const SPEED = 180
const JUMPFORCE = -1000 
const GRAVITY = 35

func jump():
	player1Velocity.y = JUMPFORCE

func move_right():
	player1Velocity.x = SPEED
	$Sprite.play("walk")
	$Sprite.flip_h = false

func move_left():
	player1Velocity.x = -SPEED
	$Sprite.play("walk")
	$Sprite.flip_h = true
	
func _physics_process(delta):
	if Input.is_action_pressed("right"):
		move_right()	
	elif Input.is_action_pressed("left"):
		move_left()		
	else:
		$Sprite.play("idle") 
		
	if not is_on_floor():
		$Sprite.play("jump")
		
	player1Velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMP_COUNT:
		jump()
		jump_count+=1
	if is_on_floor():
		jump_count=0
	
	player1Velocity = move_and_slide(player1Velocity,Vector2.UP)
	
	player1Velocity.x = lerp(player1Velocity.x,0,0.3)
	
	
	
	
