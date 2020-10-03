extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.connect("generator_broken",self,'quit')

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		quit()
		
func quit():
	queue_free()
	get_parent().remove_scene()
		
