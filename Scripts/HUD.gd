extends CanvasLayer

signal hero_dead
signal fireballs_empty

const COINS_TO_WIN = 9
const MAX_LIFE = 50
const MAX_FIREBALLS = 20

var coins = 0
var life = MAX_LIFE
var fireballs = MAX_FIREBALLS

func _ready():
	$Coins.text = String(coins)
	$Fireballs.text = String(fireballs)
	$Life.text = String(life)
	
func _on_coin_collected():
	coins = coins + 1
	_ready()
	if coins == COINS_TO_WIN:
		get_tree().change_scene("res://Scenes/Win.tscn")
	
func _on_fireball_collected(fireball_cnt):
	if fireballs + fireball_cnt <= MAX_FIREBALLS:
		fireballs = fireballs + fireball_cnt
	else:
		fireballs = MAX_FIREBALLS
	_ready()
		
func _on_fireball_used():
	if fireballs > 0:                 
		fireballs = fireballs - 1
	if fireballs == 0:
		emit_signal("fireballs_empty")
	_ready()
		
func _on_heart_collected(life_cnt):
	if life + life_cnt <= MAX_LIFE:
		life = life + life_cnt
	else:
		life = MAX_LIFE
	_ready()
		
func _on_life_lost(hit_points):
	if life > 0:                 
		life = life - hit_points
	if life <= 0:
		emit_signal("hero_dead")
	_ready()
