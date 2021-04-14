extends Position2D

export (Array, PackedScene) var scenes

var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0
var timer_mean = .06
var timer_var = .05
var in_level_transition = false
var colors = [0,3,6,9]
var level_color = 0
var rarity = .8

onready var timer = $Timer

func _ready():
	Signals.connect("level_up",self,"set_transition")
	Signals.connect("scroll_increase",self,"decrease_freq")
	Signals.connect("level_color",self,"set_color")
	pass

func _on_Timer_timeout():
	if(!Signals.game_over):
		random_scene.randomize()
		timer.wait_time = 1 + random_scene.randfn(timer_mean, timer_var)
		selected_scene_index = random_scene.randi_range(1, scenes.size()-1)
		var tmp = scenes[selected_scene_index].instance()
		tmp.get_node("platform").frame = colors[level_color]
		add_child_below_node(self,tmp)

func set_color(color):
	level_color = color

func set_transition():
	timer.stop()
	timer.paused = true
	Signals.emit_signal("in_transition")

func decrease_freq():
	rarity = min(0, rarity - .05)
	timer_mean += .1
	timer_var += .005
	timer.paused = false
	timer.start()
	
