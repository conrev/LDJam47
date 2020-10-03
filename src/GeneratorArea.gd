extends GameEnterArea
onready var smoke = $CPUParticles2D

func _ready():
	ResourceManager.connect("generator_broken",self,'start_smoke')
	ResourceManager.connect("generator_fixed",self,'stop_smoke')

func _unhandled_input(event):
	if get_overlapping_bodies().size() > 0:
		if event.is_action_pressed("ui_enter"):
			if ResourceManager.generator_broken:
				get_parent().add_scene(scene_to_load)
			else:
				ResourceManager.emit_signal("message_requested","Generator is not Broken, Nothing to Do Here", 2)
			
func start_smoke():
	smoke.emitting = true

func stop_smoke():
	smoke.emitting = false
