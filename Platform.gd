extends KinematicBody2D

var rand_loc = RandomNumberGenerator.new()
var rand_color = RandomNumberGenerator.new()

onready var sprite = $platform
onready var score_ui = preload("res://ScoreUI.tscn")

func _ready():
	Signals.connect("scroll_increase",self,"despawn")
	Signals.connect("restart",self,"despawn")
	rand_loc.randomize()
	position = Vector2(position.x, position.y + rand_loc.randfn(-5,5))
	pass 

func _physics_process(delta):
	if(!Signals.game_over):
		position += Vector2(-Signals.scroll_speed,0)
	else:
		position += Vector2(-0.25,0)

func _on_detector_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("add_score",1)
		Signals.emit_signal("made_jump")

func despawn():
	queue_free()
