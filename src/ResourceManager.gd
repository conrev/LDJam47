extends Node

signal hunger_changed(new_val)
signal thirst_changed(new_val)
signal electricity_changed(new_val)


var hunger = 100
var electricity = 100
var thirst = 100

var e_decay = 0.1
var h_decay = 0.02
var t_decay = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func _physics_process(delta):
	electricity -= e_decay
	electricity = clamp(electricity,0,100)
	emit_signal("electricity_changed",electricity)
	hunger -= h_decay
	hunger = clamp(hunger,0,100)
	emit_signal("hunger_changed",hunger)
	thirst -= t_decay		
	thirst = clamp(thirst,0,100)
	emit_signal("thirst_changed",thirst)

func game_start():
	set_physics_process(true)

func add_electricity(value):
	electricity += value
	
func add_thirst(value):
	print(thirst)
	thirst+= value
	print(thirst)
	
func add_hunger(value):
	hunger+= value


func remove_electricity(value):
	electricity-= value
	
func remove_thirst(value):
	thirst-= value
	
func remove_hunger(value):
	hunger-= value
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
