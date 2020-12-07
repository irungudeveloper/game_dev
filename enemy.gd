extends KinematicBody2D

var enemyvelocity = Vector2()
export var direction = -1
export var detectfloor = true
var speed = 50

func bounce():
	pass

func _physics_process(delta):
	
	if  not $floordetector.is_colliding() and detectfloor and is_on_floor() :
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floordetector.position.x = $CollisionShape2D.shape.get_extents().x * direction

	if is_on_wall():
		pass
	
	enemyvelocity.y += 20
	enemyvelocity = move_and_slide(enemyvelocity, Vector2.UP)
	enemyvelocity.x = speed * direction

func _ready():
	if direction == 1:
		#$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	$floordetector.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floordetector.enabled = detectfloor

func _on_topcheck_body_entered(body):
	$AnimatedSprite.play("die")
	speed = 0
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$enemykilled.play()
	
	body.bounce()
	
	print("top entered")
	
	$topcheck.set_collision_layer_bit(4,false)
	$topcheck.set_collision_mask_bit(0,false)
	$leftcheck.set_collision_layer_bit(4,false)
	$leftcheck.set_collision_mask_bit(0,false)
	$leftcheck2.set_collision_layer_bit(4,false)
	$leftcheck2.set_collision_mask_bit(0,false)
	
	$Timer.start()

func _on_sidecheck_body_entered(body):
	print("side entered")
	body.hurt(position.x)


func _on_Timer_timeout():
	queue_free()
