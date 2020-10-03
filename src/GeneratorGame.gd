extends CanvasLayer


var is_dragging = false
var start_drag = null
var end_drag  = Vector2.ZERO
var drag_color = ""
var drag_sides = ""
var dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	$LeftGenerator.create_electric_drag()
	$RightGenerator.create_electric_drag()
	#pass # Replace with function body.

func start_drag(source, color, sides):
	if !source.connected:
		print('Dragging!')
		is_dragging = true
		start_drag = source
		drag_color = color
		drag_sides = sides

func end_drag(target, color, sides):
	print('Ending Drag')
	print(drag_color,drag_sides)
	print(color,sides)
	is_dragging = false
	if color == drag_color and sides != drag_sides:
		start_drag.connect_electric_drag(target)
		dictionary[color] = true
		
	
func _unhandled_input(event):
	if event is InputEventMouseButton and !event.is_pressed():
		end_drag(Vector2.ZERO,"NULL","NULL")
	if event.is_action_pressed("ui_cancel"):
		quit()
		
func quit():
	queue_free()
	get_parent().remove_scene()

func _physics_process(delta):
	if dictionary.size()==3:
		ResourceManager.fix_generator()
		quit()
