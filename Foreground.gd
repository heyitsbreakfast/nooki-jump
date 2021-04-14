extends Node2D

signal touching

onready var scrolling = $ScrollingBackground
var game_over = false

func _ready():
	Signals.connect("scroll_increase",self,"increase_scroll")
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("death")

func increase_scroll():
	var new_speed = Signals.scroll_speed*.1
	scrolling.get_material().set_shader_param("increase_speed",new_speed)
