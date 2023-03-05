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
	
func _on_coin_collected(coin_name):
	coins = coins + 1
	
	GameState.coins = coins
	GameState.coins_collected[coin_name] = true
		
	if coins == Globals.COINS_FOR_EXTRA_LIFE:
		if life + Globals.EXTRA_LIFE <= Globals.MAX_LIFE:
			life = life + Globals.EXTRA_LIFE
		else:
			life = Globals.MAX_LIFE
		coins = 0
	_ready()
		
func _on_fireball_collected(fireball_cnt, fireball_name, mystery_box):
	if fireballs + fireball_cnt <= Globals.MAX_FIREBALLS:
		fireballs = fireballs + fireball_cnt
	else:
		fireballs = Globals.MAX_FIREBALLS
		
	GameState.fireballs = fireballs
	
	if not mystery_box:
		var node_idx = fireball_name.lstrip(Globals.NODE_FIREBALLS_NAME)
		GameState.set("fireball_" + str(node_idx) + "_collected", true)
		GameState.save_config()
	
	emit_signal("has_fireballs")
	_ready()
		
func _on_fireball_used():
	if fireballs > 0:                 
		fireballs = fireballs - 1
	if fireballs == 0:
		emit_signal("fireballs_empty")
		
	GameState.fireballs = fireballs	
		
	_ready()

func _on_key_collected(_key_name):
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
		
func _on_heart_collected(life_cnt, heart_name, mystery_box):
	if life + life_cnt <= Globals.MAX_LIFE:
		life = life + life_cnt
	else:
		life = Globals.MAX_LIFE
		
	GameState.life = life
	
	if not mystery_box:
		var node_idx = heart_name.lstrip(Globals.NODE_HEART_NAME)
		GameState.set("heart_" + str(node_idx) + "_collected", true)
		GameState.save_config()	
		
	_ready()
		
func _on_life_lost(hit_points):
	if life > 0:                 
		life = life - hit_points
	if life <= 0:
		emit_signal("hero_dead")
		
	GameState.life = life	
		
	_ready()
