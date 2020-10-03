extends KinematicBody2D
var snap = false
var speed = 250
var velocity = Vector2()
var gravity = 1000

func _physics_process(delta):
	var direction_x = Input.get_action_strength("ui_right") - Input.get_action_strength('ui_left')
	velocity.x = direction_x * speed
	velocity.y += gravity * delta
	var snap_vector = Vector2(0,32)
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, true,4,deg2rad(60))
	#if is_on_floor() and (Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left")):
	#	velocity.y = 0
	#var just_landed = is_on_floor() and not snap
	#if just_landed:
#		snap=true
		
