extends TextureButton

func _ready():
	pass # Replace with function body.

func _on_Start_pressed():
	Signals.emit_signal("game_start")
	get_tree().change_scene("res://Main.tscn")
