extends KinematicBody2D

const UP = Vector2(0,-1)
const JUMP = 200

var fall_speed = 170
var gravity = 8
var motion = Vector2()
var jump_count
var score = 0
var player_speed
var max_jump_count = 3
var hold_length : float
var combo_status = false

onready var sprite = $AnimatedSprite
onready var ehh = $Ehh
onready var meep = $Meep
onready var points = $Points

func _ready():
	points.set_modulate(Color(1,1,1,0))
	player_speed = Signals.scroll_speed
	Signals.connect("scroll_increase",self,"reset_pos")
	Signals.connect("combo_status",self,"combo_status")
	Signals.connect("made_jump",self,"show_score")
	Signals.connect("death",self,"death")

func _physics_process(delta):
	player_speed = Signals.scroll_speed
	
	if is_on_floor():
		position += Vector2(player_speed,0)
		sprite.play("run")
	motion.y += gravity
	if motion.y > fall_speed:
		sprite.play("fall")
		motion.y = fall_speed
	
	if Input.is_action_just_pressed("jump"):
		sprite.play("jump")
		jump()
	
	if hold_length >= .6 && (Input.is_mouse_button_pressed(BUTTON_LEFT) || Input.is_action_pressed("jump")):
		fall_speed = 40
		gravity = 9
	elif hold_length < .6:
		hold_length += delta
		gravity = 8
		fall_speed = 170
	else:
		gravity = 8
		fall_speed = 170
	
	motion = move_and_slide(motion, UP)

func death():
	ehh.play()

func reset_pos():
#	var tmp
#	if(position.x < 68.298):
#		player_speed += .3
#	player_speed = tmp
	pass

func jump():
	if is_on_floor():
		meep.play()
		motion.y = -JUMP
		jump_count = 0
	else:
		jump_count += 1
		if jump_count < max_jump_count:
			motion.y = -JUMP * 1 * .5
	Signals.emit_signal("jump_count", jump_count)

func get_jump():
	return jump_count

func combo_status(in_combo):
	if in_combo:
		sprite.material.set_shader_param("apply", true)
	else:
		sprite.material.set_shader_param("apply", false)

func _on_Ehh_finished():
	queue_free()

func show_score():
	
	if points.text != null:
		if jump_count == 0:
			points.text = "Perfect Jump! \n+100"
		elif jump_count == 1:
			points.text = "+50"
		else:
			points.text = "+30"
		hold_length = 0
		Signals.emit_signal("show_points")

func _on_PointTimer_timeout():
	pass

