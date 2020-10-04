extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(body : PhysicsBody2D):
	if body is KinematicBody2D:
		body.rotation_degrees = 53



func _on_Area2D_body_exited(body):
	if body is KinematicBody2D:
		body.rotation_degrees = 0
	body.rotation_degrees = 0
