extends Area2D
class_name GameEnterArea

export(String) var scene_to_load

func _ready():
	ResourceManager.connect("game_over",self,'disable_input')

func disable_input(_args):
	set_process_unhandled_input(false)

func get_reward():
	ResourceManager.electricity+=10
	ResourceManager.hunger-=10

func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		$Sprite.material.set_shader_param("enabled",true)
		if event.is_action_pressed("ui_enter"):
			$AudioStreamPlayer.play()
			get_parent().add_scene(scene_to_load)
	else:
		$Sprite.material.set_shader_param("enabled",false)
