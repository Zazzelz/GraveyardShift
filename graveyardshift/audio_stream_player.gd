extends AudioStreamPlayer

const menu_music = preload("res://01_Assets/Audio/DavidKBD - Spooky Pack - Spooky Playtime-08 - Whispers of Darkness.ogg")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()

func play_menu_music():
	_play_music(menu_music)
