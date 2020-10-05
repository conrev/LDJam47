extends Node2D

onready var animator = $AnimationPlayer
onready var game_over_msg = $UILayer/GameOver/Label2
onready var survival_time = $UILayer/TimeContainer/SurvivalTime
onready var survival_end = $UILayer/GameOver/SurvivalTime
onready var global_light = $GlobalLight
onready var music_player = $NormalPlayer
onready var danger_player = $DangerPlayer
onready var basic_music = preload("res://Assets/Music/Ludum_Dare_47_Standard_Music.ogg")
onready var danger_music = preload("res://Assets/Music/Ludum_Dare_47_Danger_Music.ogg")
onready var ghost_scene = preload("res://src/Ghost.tscn")
var scene_open = false
var scene_running = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.game_start()
	animator.play("GameStart")
	music_player.stream = basic_music
	music_player.play()
	danger_player.stream = danger_music
	danger_player.volume_db = -90
	ResourceManager.connect("game_over",self,"_trigger_game_over")
	ResourceManager.connect("electricity_changed",self,"change_light_power")
	ResourceManager.connect("time_increased",self,"update_time")
	ResourceManager.connect("danger_started",self,"fade_to_danger")
	ResourceManager.connect("danger_stopped",self,"fade_to_normal")
	
func add_scene(path):
	if scene_open:
		print('Opened Scene Exist',path)
	else:
		scene_open = true
		$HamBoi.set_physics_process(false)
		animator.play("ChangeScene")
		yield(animator,"animation_finished")
		instantiate(path) 
		

func remove_scene():
	scene_open = false
	if is_instance_valid(scene_running):
		scene_running.queue_free()
	animator.play_backwards("ChangeScene")
	yield(animator,"animation_finished")
	$HamBoi.set_physics_process(true)
	
func instantiate(path):
	scene_running = load(path).instance()
	add_child(scene_running)

func _trigger_game_over(reason):
	yield(remove_scene(),"completed")
	$HamBoi.queue_free()
	set_physics_process(false)
	match reason:
		"electricity":
			game_over_msg.text = game_over_msg.text + "Darkness"
		"hunger":
			game_over_msg.text = game_over_msg.text + "Starvation"
		"thirst":
			game_over_msg.text = game_over_msg.text + "Thirst"
	animator.play("GameOver")
	
func change_light_power(e):
	global_light.energy = clamp(e/100 + 0.2,0.4,1)
	
func update_time(time):
	survival_time.text = str(time) + " Seconds"
	survival_end.text = str(time) + " Seconds"

func _physics_process(delta):
	if ResourceManager.electricity < 50:
		var rand = ResourceManager.rng.randi_range(0,120)
		if rand == 100:
			var x = ResourceManager.rng.randi_range(180,1100)
			var y = ResourceManager.rng.randi_range(50,550)
			var instance = ghost_scene.instance()
			add_child(instance)
			instance.global_position = Vector2(x,y)

func fade_to_normal():
	music_player.play()
	$Tween.interpolate_property(music_player,"volume_db",-40,0,3)	
	$Tween.interpolate_property(danger_player,"volume_db",0,-40,3)
	$Tween.start()
	yield($Tween,"tween_completed")
	danger_player.stop()
	
func fade_to_danger():
	danger_player.play()
	$Tween.interpolate_property(music_player,"volume_db",0,-40,3)
	$Tween.interpolate_property(danger_player,"volume_db",-40,0,3)
	$Tween.start()	
	yield($Tween,"tween_completed")
	music_player.stop()
