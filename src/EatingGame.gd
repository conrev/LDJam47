extends CanvasLayer

onready var seed_scene = preload("res://src/Seed.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	create_new_seed()
	
func create_new_seed():
	var instance = seed_scene.instance()
	add_child(instance)
	instance.global_position = Vector2(512,300)


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		queue_free()
		get_parent().remove_scene()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
