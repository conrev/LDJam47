extends CanvasLayer

onready var droplet_scene = preload("res://src/WaterDrops.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drop_rate = 1
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = drop_rate
	timer.connect("timeout",self,'generate_droplet')
	add_child(timer)
	timer.start()
	
func generate_droplet():
	var instance = droplet_scene.instance() 
	add_child(instance)
	var x = ResourceManager.rng.randi_range(0,1280)
	instance.global_position= Vector2(x,0)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		queue_free()
		get_parent().remove_scene()
