extends KinematicBody2D

onready var animator = $AnimationPlayer
onready var sprite = $"animal-hamster-001"
var snap = false
var speed = 250
var velocity = Vector2()
var gravity = 20
var is_jumping = true

func _ready():
	animator.play("Idle")
	ResourceManager.connect("game_over",self,'disable_input')

func disable_input(_args):
	set_physics_process(false)

func _physics_process(delta):
	var direction_x = 0
	if Input.is_action_pressed("ui_right"):
		direction_x = 1
		if is_on_floor():
			animator.play("Walk")
	elif Input.is_action_pressed("ui_left"):
		direction_x = -1
		if is_on_floor():
			animator.play("Walk")
	else:
		if is_on_floor():
			animator.play("Idle")
	
	
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y -= 800
	
	velocity.x = direction_x * speed
	velocity.y += gravity
	
		
	
	#var snap_vector = Vector2(0,32)
	#velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true,4,deg2rad(60))
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	
	if !is_on_floor():
		if velocity.y < 0:
			$AnimationPlayer.play("Jump")
		else:
			$AnimationPlayer.play("Fall")
	
	animate(velocity)
	#if is_on_floor() and (Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left")):
	#	velocity.y = 0
	#var just_landed = is_on_floor() and not snap
	#if just_landed:
#		snap=true

func animate(velocity):
	#if !is_on_floor():
	#	if velocity.y < 0:
	#		animator.play("Jump")
	#	else:
		#	animator.play("Fall")
	#	animator.play("Jump")
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false
	#else:
	#	animator.play("Idle")
		
		
