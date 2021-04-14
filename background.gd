extends Sprite

func _ready():
	self.frame = 0
	Signals.connect("game_start",self,"change_to_game")

func change_to_game():
	self.frame = 0
