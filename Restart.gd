extends TextureButton

onready var timer = $Timer

func _ready():
	Signals.connect("death",self,"game_over")
	self.visible = false
	self.disabled = true

func game_over():
	timer.start()

func _on_Restart_pressed():
	Signals.emit_signal("restart_clicked")
	self.visible = false
	self.disabled = true


func _on_Timer_timeout():
	self.visible = true
	self.disabled = false
