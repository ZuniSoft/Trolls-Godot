extends CanvasLayer

signal hero_dead
signal fireballs_empty
signal has_fireballs

const COINS_FOR_EXTRA_LIFE = 12
const EXTRA_LIFE = 20
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
	if coins == COINS_FOR_EXTRA_LIFE:
		if life + EXTRA_LIFE <= MAX_LIFE:
			life = life + EXTRA_LIFE
		else:
			life = MAX_LIFE
		coins = 0
	_ready()
		
func _on_fireball_collected(fireball_cnt):
	if fireballs + fireball_cnt <= MAX_FIREBALLS:
		fireballs = fireballs + fireball_cnt
	else:
		fireballs = MAX_FIREBALLS
	emit_signal("has_fireballs")
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
