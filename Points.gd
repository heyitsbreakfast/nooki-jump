extends Label

onready var tween = $Tween

func _ready():
	Signals.connect("show_points",self,"show_points")


func show_points():
	self.rect_position = Vector2(-50,-10)
	tween.interpolate_property(self, "modulate:a",
			1.0, 0.0, 0.6,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "rect_position", rect_position, rect_position - Vector2(0,30),
			0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
