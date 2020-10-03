extends Area2D
class_name GameEnterArea


func get_reward():
	ResourceManager.electricity+=10
	ResourceManager.hunger-=10

func _unhandled_input(event):
	if event.is_action_pressed("ui_enter"):
		if get_overlapping_bodies().size() > 0:
			get_reward()
			
