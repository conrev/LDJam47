extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		$AnimationPlayer.play("Clicked")
		yield($AnimationPlayer,"animation_finished")
		get_tree().reload_current_scene()
