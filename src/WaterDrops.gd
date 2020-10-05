extends RigidBody2D

onready var droplet_sound = preload("res://Assets/Music/droplet.wav")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.2), "timeout")
	$AudioStreamPlayer.stream = droplet_sound
	$AudioStreamPlayer.play()

func _on_screen_exited():
	queue_free()
