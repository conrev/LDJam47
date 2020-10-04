extends Area2D

onready var animator = $AnimationPlayer

func _ready():
	pass
	
	
func _physics_process(delta):
	global_position.x = get_global_mouse_position().x


func _on_HamboiDrinking_body_entered(body):
	body.queue_free()
	generate_thirst()
	animator.play("Gulp")
	
func generate_thirst():
	ResourceManager.thirst+=4
