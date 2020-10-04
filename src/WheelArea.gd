extends Area2D

func _ready():
	ResourceManager.connect("game_over",self,'disable_input')

func disable_input(_args):
	set_process_unhandled_input(false)

func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		if event.is_action_pressed("ui_enter"):
			if ResourceManager.generator_broken:
				ResourceManager.emit_signal("message_requested","Generator is Broken, Fix it First", 2)
			else:
				print('ini jalan')
				get_parent().add_scene("res://src/WheelGame.tscn")
			

