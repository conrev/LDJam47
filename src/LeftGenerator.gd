extends Node2D

export var SIDES = "LEFT"

onready var drag_scene = preload("res://src/ElectricDrag.tscn")

var color_dict = {"RED":Color(1,0,0),"GREEN":Color(0,1,0),"BLUE":Color(0,0,1)}	
func _ready():
	pass
	
func _draw():
	if get_parent().is_dragging:
		draw_line(get_parent().start_drag.global_position-global_position,get_global_mouse_position()-global_position,get_parent().start_drag.color_obj,3.0)

func _process(delta):
	update()

func create_electric_drag():
	var choice = ["RED","BLUE","GREEN"]
	choice.shuffle()
	for i in range(3):
		var instance = drag_scene.instance()
		add_child(instance)
		instance.color = choice[i]
		instance.sides = SIDES
		instance.position = Vector2(0,i*100)
		instance.set_color(color_dict[choice[i]])
		
		
