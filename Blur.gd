extends ColorRect

func _ready():
	Signals.connect("death",self,"game_over")
	Signals.connect("restart",self,"restart")
	self.visible = false

func game_over():
	self.visible = true

func restart():
	self.visible = false
