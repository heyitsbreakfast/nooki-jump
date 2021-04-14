#NOOKI JUMP!
extends Control

var jump_counter = 0
var score = 0
var goal = 1500
var level = 1 setget , get_level
var combo = 0
var in_combo = false

onready var score_label = $Score
onready var level_label = $Level
onready var combo_label = $Combo

func _ready():
	combo_label.visible = false
	Signals.connect("jump_count", self, "set_jump_count")
	Signals.connect("add_score", self, "add_score")
	Signals.connect("scroll_increase",self,"set_level")

func add_score(added_score):
	
	if combo == 2 && jump_counter == 0:
		combo_label.visible = true
		in_combo = true
		if combo_label != null:
			combo_label.text = "Combo Mode!"
	elif combo != 2 && jump_counter == 0:
		in_combo = false
		combo += 1
	else:
		in_combo = false
		combo_label.visible = false
		combo = 0
	
	if in_combo:
		score += stepify(added_score*100/(jump_counter+1),10)*2
	else:
		score += stepify(added_score*100/(jump_counter+1),10)
	
	if score >= goal:
		goal += 1500
		level += 1
		Signals.emit_signal("level_up")
	
	if score_label != null:
		score_label.text = "Score: " + str(score)
	
	Signals.emit_signal("combo_status", in_combo)

func set_jump_count(count):
	jump_counter = count

func get_level():
	return level

func set_level():
	if level_label != null:
		level_label.text = "Level: " + str(level)
