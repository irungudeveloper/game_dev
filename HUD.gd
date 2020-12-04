extends CanvasLayer

var coinsdisplay = 0

func _ready():
	$coinLabel.text = String(coinsdisplay)

func _physics_process(delta):
	if coinsdisplay == 4:
		get_tree().change_scene("res://Level1.tscn")
	

func _on_coin_hud():
	coinsdisplay +=1
	_ready()
