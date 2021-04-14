extends KinematicBody2D

onready var sprite = $Sprite
onready var rand_color = RandomNumberGenerator.new()
var color

func _ready():
	sprite.frame = 0
	Signals.connect("in_transition",self,"set_pos")

func _physics_process(delta):
	if(!Signals.game_over):
		position += Vector2(-Signals.scroll_speed,0)
	else:
		position += Vector2(-0.25,0)

func set_pos():
	rand_color.randomize()
	if sprite.frame == 3:
		sprite.frame = 0
	else:
		sprite.frame += 1
	Signals.emit_signal("level_color", sprite.frame)
	self.position = Vector2(550, 116)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("scroll_increase")
