extends Node

signal hunger_changed(new_val)
signal thirst_changed(new_val)
signal electricity_changed(new_val)
signal generator_broken
signal generator_fixed
signal message_requested(msg, time)
signal wiggle_ui(resource)
signal game_over(reason)
signal time_increased(survival_time)
signal danger_started
signal danger_stopped


var danger = false
var generator_broken = false
var hunger = 100
var electricity = 100
var thirst = 100


var e_decay = 0.02
var h_decay = 0.01
var t_decay = 0.01
var rng = RandomNumberGenerator.new()
var survival_time = 0
var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.process_mode =Timer.TIMER_PROCESS_PHYSICS
	timer.wait_time = 1
	timer.connect("timeout",self,'increment_survival_time')
	rng.randomize()
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
	check_game_over()
	check_danger()
	var x = rng.randi_range(0,3600)
	if x == 60:
		break_generator()
	
func game_start():
	generator_broken=false
	hunger = 100
	electricity = 100
	thirst = 100
	survival_time = 0
	timer.start()
	set_physics_process(true)
	
func game_stop():
	set_physics_process(false)
	timer.stop()
	
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

func break_generator():
	if !generator_broken:
		generator_broken = true
		emit_signal("generator_broken")
		emit_signal("message_requested",'Generator is Broken, Fix it Immediately',0)

func fix_generator():
	generator_broken = false
	emit_signal("generator_fixed")
	emit_signal("message_requested",'Generator Fixed!',1)

func check_game_over():
	if hunger <= 0:
		emit_signal("game_over","hunger")
		game_stop()
	if thirst <=0:
		emit_signal("game_over","thirst")
		game_stop()
	if electricity <=0:
		emit_signal("game_over","electricity")
		game_stop()

func check_danger():
	if hunger <= 40 or thirst<= 40 or electricity<= 40:
		start_danger()
	elif hunger >= 60 or thirst >= 60 or electricity >=60:
		stop_danger()


func start_danger():
	if !danger:
		emit_signal("danger_started")
		danger = true
		
func stop_danger():
	if danger:
		emit_signal("danger_stopped")
		danger = false


func increment_survival_time():
	survival_time+=1
	emit_signal("time_increased",survival_time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
