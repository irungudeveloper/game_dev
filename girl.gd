extends KinematicBody2D

#by irungu_developer

var girlVelocity = Vector2(0,0) 
var jump_count = 0
const MAX_JUMP_COUNT = 1
const SPEED = 320
const JUMPFORCE = -900 
const GRAVITY = 35

func jump():
	girlVelocity.y = JUMPFORCE

func move_right():
	girlVelocity.x = SPEED
	$AnimatedSprite.play("walk")
	$AnimatedSprite.flip_h = false
	
func move_left():
	girlVelocity.x = -SPEED
	$AnimatedSprite.play("walk")
	$AnimatedSprite.flip_h = true
	
func _physics_process(delta):
	if Input.is_action_pressed("right"):
		move_right()	
	elif Input.is_action_pressed("left"):
		move_left()		
	else:
		$AnimatedSprite.play("idle") 
		
	if not is_on_floor():
		$AnimatedSprite.play("jump")
		
	girlVelocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMP_COUNT:
		jump()
		jump_count+=1
	if is_on_floor():
		jump_count=0
	
	girlVelocity = move_and_slide(girlVelocity,Vector2.UP)
	
	girlVelocity.x = lerp(girlVelocity.x,0,0.3)
	
	#r=12
	#center = (100,100)
	#midpoint-circle 
	
	
	
	


func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")
