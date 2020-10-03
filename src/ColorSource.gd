extends Area2D

var color = "Blue"
var color_obj = null
var sides = "Left"
var connected = false
var target = null

onready var generator = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		generator.start_drag(self,color,sides)
	if event is InputEventMouseButton and !event.is_pressed():
		generator.end_drag(self,color,sides)

func set_color(col):
	$Sprite.modulate = col
	color_obj = col

func _draw():
	if connected:
		draw_line(Vector2.ZERO, target.global_position-global_position,color_obj,5)
	
func _process(delta):
	update()	
	
func connect_electric_drag(tgt):
	if !connected:
		connected = true
		target = tgt
		target.connect_electric_drag(self)
	
