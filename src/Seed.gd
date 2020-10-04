extends KinematicBody2D


export var decay = 0.8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(5, 5)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

onready var animator = $AnimationPlayer
onready var noise = OpenSimplexNoise.new()
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
var noise_y = 0
var last_pos = Vector2()


onready var cracks = preload("res://src/CrackParticle.tscn")
var crack_count = 0
var gravity = Vector2.ZERO
var velocity = Vector2.ZERO
var timer = Timer.new()
var cracked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout",self,'generate_food')
	timer.one_shot = true

func _physics_process(delta):
	velocity += gravity
	move_and_collide(velocity*delta)
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index==1 and event.is_pressed():
		if crack_count <3:
			crack_count += 1
			var instance = cracks.instance()
			add_child(instance)
			instance.emitting=true
			add_trauma(2)
		if crack_count == 3:
			animator.play("Crack")
			crack_count+=1
	if event is InputEventMouseButton and event.button_index==2 and event.is_pressed():
		start_fall()
		
func start_fall():
	velocity = Vector2(300,-800)
	gravity = Vector2(0,98)
	timer.start()

func generate_food():
	if crack_count > 3:
		ResourceManager.hunger+=5
	ResourceManager.thirst-=3
	queue_free()
	get_parent().create_new_seed()

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	else:
		pass
		#global_position = Vector2(512,300)
		
func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	# Using noise
	var offset = Vector2()
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	$Sprite.offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	$Sprite.offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
	#global_position+=offset
	
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
