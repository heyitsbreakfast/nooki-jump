extends Node2D

signal death
signal add_score
signal jump_count
signal level_up
signal in_transition
signal scroll_increase
signal despawn
signal level_color
signal restart
signal restart_clicked
signal made_jump
signal game_start
signal show_points
signal combo_status

onready var scroll_speed = .5
var first_inc = true
var game_over = false
var in_combo = false

func _ready():
	Signals.connect("scroll_increase",self,"increase_scroll")
	Signals.connect("combo_status",self,"combo_status")
	Signals.connect("death",self,"game_over")
	Signals.connect("restart",self,"restart")

func increase_scroll():
	if first_inc:
		self.scroll_speed = 1.1
		first_inc = false
	else:
		self.scroll_speed += .2

func game_over():
	game_over = true

func restart():
	first_inc = true
	scroll_speed = .5
	game_over = false

func combo_status(value):
	if value && !in_combo:
		self.scroll_speed *= 1.5
		in_combo = true
	elif !value && in_combo:
		self.scroll_speed /= 1.5
		in_combo = false
	else:
		pass
