extends Area2D

signal coin_hud

func _on_coin_body_entered(body):
	$AnimationPlayer.play("coinbounce")	
	$coincollected.play()
	emit_signal("coin_hud")
	set_collision_mask_bit(0,0)
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
