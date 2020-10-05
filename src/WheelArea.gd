extends Area2D

onready var success_music = preload("res://Assets/Music/enter_area_success.wav")
onready var fail_music = preload("res://Assets/Music/enter_area_fail.wav")

func _ready():
	$Keys.visible = false	
	ResourceManager.connect("game_over",self,'disable_input')

func disable_input(_args):
	set_process_unhandled_input(false)

func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		$Keys.visible = true
		$Sprite.material.set_shader_param("enabled",true)
		if event.is_action_pressed("ui_enter"):
			if ResourceManager.generator_broken:
				$AudioStreamPlayer.stream = fail_music
				$AudioStreamPlayer.play()
				ResourceManager.emit_signal("message_requested","Generator is Broken, Fix it First", 2)
			else:
				$AudioStreamPlayer.stream = success_music
				$AudioStreamPlayer.play()
				get_parent().add_scene("res://src/WheelGame.tscn")
	else:
		$Sprite.material.set_shader_param("enabled",false)
		$Keys.visible = false
func _physics_process(delta):
	$Sprite.rotation_degrees-=0.1
