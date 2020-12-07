extends CanvasLayer

var coinsdisplay = 0
var life = 3
var diamonds = 0

func _ready():
	$coinLabel.text = String(coinsdisplay)	
	$gemLabel.text = String(diamonds)
	$heartLabel.text = String(life)
	
func _on_coin_hud():
	coinsdisplay +=1
	#if coinsdisplay == 4:
		#get_tree().change_scene("res://Level1.tscn")
	_ready()

func _on_diamond_collected():
	diamonds+=1
	_ready()


func _on_girl_life_hit():
	life-=1
	if life > 0:
		$heartLabel.text=String(life)
	else:
		$heartLabel.text=String("0")
