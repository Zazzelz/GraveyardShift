extends CanvasLayer

@onready var animation_tree: AnimationTree = $AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MenuMusic.play_menu_music()


func _on_back_button_pressed() -> void:
	$Settings/Click.play()
	animation_tree.set("parameters/menuTransition/transition_request", "exit")

	
	
