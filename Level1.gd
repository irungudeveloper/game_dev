extends Node2D


func _ready():
	$Timer.start()
	
func _process(delta):
	$HUD/timer_label.text = String($Timer.time_left)
	
func _on_Timer_timeout():
	print("timeout")
