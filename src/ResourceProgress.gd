extends ProgressBar

export var resource : String 
onready var tweener = $Tween

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("%s_changed"%resource)
	ResourceManager.connect("%s_changed"%resource,self,'_on_resource_changed')
	
func _on_resource_changed(val):
	value = val
