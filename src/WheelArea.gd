extends GameEnterArea


func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		if event.is_action_pressed("ui_enter"):
			if ResourceManager.generator_broken:
				ResourceManager.emit_signal("message_requested","Generator is Broken, Fix it First", 2)
			else:
				get_parent().add_scene(scene_to_load)
			

