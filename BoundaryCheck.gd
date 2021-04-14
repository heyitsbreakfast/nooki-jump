extends Area2D

signal touching

func _ready():
	pass # Replace with function body.


func _on_BoundaryCheck_body_entered(body):
	Signals.emit_signal("despawn")
