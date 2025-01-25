extends Control

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer

#func _ready():
	#handle_connecting_signals()

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()

#func _on_settings_pressed() -> void:
	#options.show()

#func _on_exit_options_menu() -> void: 
	#options.hide()
	#set_process(false)

#func handle_connecting_signals():
	#options.exits_options_menu.connect(_on_exit_options_menu)
