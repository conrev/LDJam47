extends Node2D

onready var animator = $AnimationPlayer
var scene_open = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.game_start()
	
func add_scene(path):
	if scene_open:
		print('Opened Scene Exist')
	else:
		scene_open = true
		$HamBoi.set_physics_process(false)
		animator.play("ChangeScene")
		yield(animator,"animation_finished")
		instantiate(path)
		

func remove_scene():
	scene_open = false
	animator.play_backwards("ChangeScene")
	yield(animator,"animation_finished")
	$HamBoi.set_physics_process(true)
	
func instantiate(path):
	add_child(load(path).instance())

func _physics_process(delta):
	pass
	#print('Electricity:',ResourceManager.electricity)
	#print('Hunger:',ResourceManager.hunger)
	#print('Thirst:',ResourceManager.thirst)

	
	
