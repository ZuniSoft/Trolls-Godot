extends Area2D

export var switch_door = 1

onready var switch_door_to_open = get_node("../../Doors/SwitchedDoor" + str(switch_door))
onready var sprite = get_node("CollisionShape2D/Sprite")

var switch_state = false
var switch_texture_open = null
var switch_texture_closed = null

func _ready():
	switch_texture_open = load("res://Assets/CommonObjects/switch-2.png")
	switch_texture_closed = load("res://Assets/CommonObjects/switch-1.png")

	sprite.set_texture(switch_texture_closed)
	update()

func _on_Switch_body_entered(_body):
	$SoundSwitch.play()
	
	if not switch_state:
		sprite.set_texture(switch_texture_open)
		switch_state = true
		switch_door_to_open.open_door()
	else:
		sprite.set_texture(switch_texture_closed)
		switch_state = false
		switch_door_to_open.close_door()

	update()
