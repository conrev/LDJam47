# Changes scenes after fading the screen on `any key` or on the A/B/cross
# buttons on a gamepad.
extends Control

const FADE_IN_TIME := 1.5
const FADE_OUT_TIME := 1.5

onready var menu_music = preload("res://Assets/Music/Ludum_Dare_47_Main_Menu.ogg")
onready var screen_fader: TextureRect = $CanvasLayer/Fader

func _ready() -> void:
	screen_fader.fade_in()
	$AudioStreamPlayer.stream = menu_music
	$AudioStreamPlayer.play()

