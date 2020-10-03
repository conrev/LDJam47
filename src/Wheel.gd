extends KinematicBody2D

var omega = 0
var alpha = 0

func _physics_process(delta):
	omega+=alpha
	alpha-=0.01
	alpha=clamp(alpha,0,0.5)
	omega-=0.1
	omega=clamp(omega,0,15)
	rotation_degrees+=omega
	generate_power(omega)
	consume_hunger(omega)

func _unhandled_input(event):
	if event.is_action_pressed("ui_run"):
		alpha+=0.1

func generate_power(omega):
	var addition = 0
	if omega>7.5:
		addition = omega/60
	ResourceManager.electricity += addition

func consume_hunger(omega):
	var addition = 0
	if omega>3:
		addition = omega/120
	ResourceManager.hunger -= addition