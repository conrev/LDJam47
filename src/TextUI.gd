extends Control

onready var label = $Label

var timer = Timer.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.connect('message_requested',self,'show_message')
	add_child(timer)
	timer.connect("timeout",self,'hide_message')

func hide_message():
	hide()
		
func show_message(msg:String, time):
	label.text = msg
	show()
	if time != 0:
		timer.wait_time=time
		timer.start()
	
	
