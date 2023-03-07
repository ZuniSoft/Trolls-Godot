extends CanvasLayer

signal hero_dead
signal fireballs_empty
signal has_fireballs
signal keys_empty
signal has_keys

var coins = GameState.coins
var life = GameState.life
var fireballs = GameState.fireballs
var keys = GameState.keys

func _ready():
	$Coins.text = String(coins)
	$Fireballs.text = String(fireballs)
	$Life.text = String(life)
	$Keys.text = String(keys)
	
func set_display_from_game_state():
	coins = GameState.coins
	life = GameState.life
	fireballs = GameState.fireballs
	keys = GameState.keys

	if fireballs > 0:
		emit_signal("has_fireballs")

	if keys > 0:
		emit_signal("has_keys")

	_ready()
	
func set_game_state_from_display():
	GameState.coins = coins
	GameState.life = life
	GameState.fireballs = fireballs
	GameState.keys = keys
	
func _on_coin_collected():
	coins = coins + 1
	
	GameState.coins = coins
		
	if coins == Globals.COINS_FOR_EXTRA_LIFE:
		if life + Globals.EXTRA_LIFE <= Globals.MAX_LIFE:
			life = life + Globals.EXTRA_LIFE
		else:
			life = Globals.MAX_LIFE
		coins = 0
	_ready()
		
func _on_fireball_collected(fireball_cnt):
	if fireballs + fireball_cnt <= Globals.MAX_FIREBALLS:
		fireballs = fireballs + fireball_cnt
	else:
		fireballs = Globals.MAX_FIREBALLS
		
	GameState.fireballs = fireballs
	
	emit_signal("has_fireballs")
	_ready()
		
func _on_fireball_used():
	if fireballs > 0:                 
		fireballs = fireballs - 1
	if fireballs == 0:
		emit_signal("fireballs_empty")
		
	GameState.fireballs = fireballs	
		
	_ready()

func _on_key_collected():
	keys = keys + 1
	
	GameState.keys = keys
	
	emit_signal("has_keys")
	_ready()
	
func _on_key_used():
	if keys > 0:                 
		keys = keys - 1
	if keys == 0:
		emit_signal("keys_empty")
		
	GameState.keys = keys
		
	_ready()
		
func _on_heart_collected(life_cnt):
	if life + life_cnt <= Globals.MAX_LIFE:
		life = life + life_cnt
	else:
		life = Globals.MAX_LIFE
		
	GameState.life = life
		
	_ready()
		
func _on_life_lost(hit_points):
	if life > 0:                 
		life = life - hit_points
	if life <= 0:
		emit_signal("hero_dead")
		
	GameState.life = life	
		
	_ready()
