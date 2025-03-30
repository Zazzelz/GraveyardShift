extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	MenuMusic.play_menu_music()
	$SettingsMenu/AnimationTree.set("parameters/menuTransition/transition_request", "entry")




	
