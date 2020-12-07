extends KinematicBody2D

#by irungu_developer

var diamonds = 0
var coins = 0
var life = 3
var girlVelocity = Vector2(0,0) 
var jump_count = 0
const MAX_JUMP_COUNT = 1
const SPEED = 400
const JUMPFORCE = -1000 
const GRAVITY = 35

signal life_hit

func bounce():
	girlVelocity.y = JUMPFORCE * 0.5

func hurt(var posx):
	emit_signal("life_hit")
	set_modulate(Color(1,0,0,0.4))	
	
	if life > 0:
		life -=1
		if position.x < posx/5:
			girlVelocity.x = -800 
		else:
			girlVelocity.x = 800
		girlVelocity.y = JUMPFORCE * 0.3
	else:
		#$Timer.start()
		Input.action_release("right")
		Input.action_release("left")
		$AnimatedSprite.play("die")
		get_tree().change_scene("res://gameover.tscn")
	
	Input.action_release("right")
	Input.action_release("left")
	
	#$Timer.start()


func jump():
	girlVelocity.y = JUMPFORCE
	$jumpsound.play()

func move_right():
	girlVelocity.x = SPEED
	$AnimatedSprite.play("walk")
	$AnimatedSprite.flip_h = false
	#$girlwalk.play(20)
	
func move_left():
	girlVelocity.x = -SPEED
	$AnimatedSprite.play("walk")
	$AnimatedSprite.flip_h = true
	#$girlwalk.play(20)
	
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
	
	
func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://gameover.tscn")


func _on_Timer_timeout():
	get_tree().change_scene("res://gameover.tscn")


func _on_diamond_collected():
	diamonds+=1
	if diamonds==5:
		get_tree().change_scene("res://win.tscn")
