extends Panel

onready var screen_fader = $"../CanvasLayer/Fader"
export(String) var scene_to_load
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		$AudioStreamPlayer.play()
		if scene_to_load == "":
			get_tree().quit()
		else:
			screen_fader.fade_out()
			yield(screen_fader, "animation_finished")
			get_tree().change_scene(scene_to_load)


func _on_Panel_mouse_entered():
	$Tween.interpolate_property(self,"rect_scale",Vector2(1,1),Vector2(1.1,1.1),0.1,Tween.TRANS_LINEAR)
	$Tween.start()
	
func _on_Panel_mouse_exited():
	$Tween.interpolate_property(self,"rect_scale",Vector2(1.1,1.1),Vector2(1,1),0.1,Tween.TRANS_SINE)
	$Tween.start()
	
