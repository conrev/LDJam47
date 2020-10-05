extends Area2D

onready var smoke = $CPUParticles2D
onready var success_music = preload("res://Assets/Music/enter_area_success.wav")
onready var fail_music = preload("res://Assets/Music/enter_area_fail.wav")
onready var explode_music = preload("res://Assets/Music/generator_break.wav")

func _ready():
	ResourceManager.connect("generator_broken",self,'start_smoke')
	ResourceManager.connect("generator_fixed",self,'stop_smoke')
	ResourceManager.connect("game_over",self,'disable_input')


func disable_input(_args):
	set_process_unhandled_input(false)

func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		$Sprite.material.set_shader_param("enabled",true)
		if event.is_action_pressed("ui_enter"):
			if ResourceManager.generator_broken:
				$AudioStreamPlayer.stream = success_music
				$AudioStreamPlayer.play()
				get_parent().add_scene("res://src/GeneratorGame.tscn")
			else:
				$AudioStreamPlayer.stream = fail_music
				$AudioStreamPlayer.play()
				ResourceManager.emit_signal("message_requested","Generator is not Broken, Nothing to Do Here", 2)
	else:
		$Sprite.material.set_shader_param("enabled",false)

func start_smoke():
	$AudioStreamPlayer.stream = explode_music
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.play()
	smoke.emitting = true

func stop_smoke():
	$AudioStreamPlayer2.stop()
	smoke.emitting = false
