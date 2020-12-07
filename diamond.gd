extends Area2D

signal diamond_collected

func _on_diamond_body_entered(body):
	emit_signal("diamond_collected")
	set_collision_mask_bit(0,0)
	queue_free()
