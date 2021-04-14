extends Node2D

var game_over = false

func _ready():
	Signals.connect("death",self,"game_over")
	Signals.connect("restart_clicked",self,"restart")

func game_over():
	game_over = true

func restart():
	if game_over:
		Signals.emit_signal("restart")
		get_tree().reload_current_scene()
