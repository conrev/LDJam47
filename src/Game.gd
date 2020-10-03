extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.game_start()
	
func _physics_process(delta):
	print('Electricity:',ResourceManager.electricity)
	print('Hunger:',ResourceManager.hunger)
	print('Thirst:',ResourceManager.thirst)

	
	
