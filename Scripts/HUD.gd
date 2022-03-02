extends CanvasLayer

signal hero_dead

const COINS_TO_WIN = 6
const MAX_LIFE = 50

var coins = 0
var life = 50

func _ready():
	$Coins.text = String(coins)
	$Life.text = String(life)
	
func _on_coin_collected():
	coins = coins + 1
	_ready()
	if coins == COINS_TO_WIN:
		get_tree().change_scene("res://Scenes/Win.tscn")
		
func _on_heart_collected(life_cnt):
	if life < MAX_LIFE:
		life = life + life_cnt
	_ready()
		
func _on_life_lost(hit_points):
	if life > 0:                 
		life = life - hit_points
	if life == 0:
		emit_signal("hero_dead")
	_ready()
