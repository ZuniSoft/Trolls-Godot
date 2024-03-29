extends Node

const COINS_FOR_EXTRA_LIFE = 12
const EXTRA_LIFE = 20

const MAX_LIFE = 50
const MAX_FIREBALLS = 20
const MAX_KEYS = 3
const MAX_LOCKED_DOORS = 3

const DROP_POS_X = 6272 #288 #6272 #7184
const DROP_POS_Y = 1300 #1424 #1488 #1264

const SCENE_FILE_NAME_IDX = 4
const SCENE_FILE_NAME_EXT = ".tscn"

const NODE_FIREBALLS_NAME = "Fireballs"
const NODE_HEART_NAME = "Heart"
const NODE_KEY_NAME = "Key"
const NODE_MYSTERY_NAME = "MysteryBox"
const NODE_ROOM_NAME = "Room"

const TRANSITION_LIGHT_WEIGHT_USE_SUB_THREADS = false
const TRANSITION_USE_SUB_THREADS = true
const TRANSITION_IMAGE_SCENE = "res://Transitions/TransitionImage.tscn"
const TRANSITION_SCENE = "res://Transitions/Transition.tscn"

const GOD_MODE = true

var is_touch_platform = false
