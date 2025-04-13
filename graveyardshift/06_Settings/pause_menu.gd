extends CanvasLayer

@onready var main = $"../"
@onready var settings: Control = $Settings
@onready var pause_window: Control = $PauseWindow

func _on_continue_button_pressed() -> void:
	main._pause_menu()
	await get_tree().create_timer(0.1).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Settings/Click.play()
	
func _on_settings_button_pressed() -> void:
	pause_window.hide()
	settings.show()
	$Settings/Click.play()
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	$Settings/Click.play()

func _on_close_button_pressed() -> void:
	main._pause_menu()
	await get_tree().create_timer(0.1).timeout
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Settings/Click.play()
	
func _on_back_button_pressed() -> void:
	settings.hide()
	pause_window.show()
	$Settings/Click.play()
