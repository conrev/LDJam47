extends Area2D
class_name GameEnterArea

export(String) var scene_to_load

func get_reward():
	ResourceManager.electricity+=10
	ResourceManager.hunger-=10

func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		if event.is_action_pressed("ui_enter"):
			get_parent().add_scene(scene_to_load)
