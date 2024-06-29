extends Control

# Sound effects
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")

# Sound busses
@onready var main_bus = AudioServer.get_bus_index("Master")
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var music_bus = AudioServer.get_bus_index("Music")

# Maximized or windowed
var windowed


# Called when the node enters the scene tree for the first time.
func _ready():
	var audio_settings = ConfigHandler.get_audio_settings()
	var video_settings = ConfigHandler.get_video_settings()

	var main_slider = $MenuPanel/MarginContainer/VBoxContainer/Content/SoundOptions/GridContainer2/MainSlider
	main_slider.value = audio_settings.main
	var music_slider = $MenuPanel/MarginContainer/VBoxContainer/Content/SoundOptions/GridContainer2/MusicSlider
	music_slider.value = audio_settings.music
	var sfx_slider = $MenuPanel/MarginContainer/VBoxContainer/Content/SoundOptions/GridContainer2/SFXSlider
	sfx_slider.value = audio_settings.sfx
	
	var mode_option_button = $MenuPanel/MarginContainer/VBoxContainer/Content/OtherOptions/Mode
	var window_mode = window_mode_to_int(video_settings.display_mode)
	print(window_mode)
	print(video_settings.display_mode)
	mode_option_button.select(window_mode)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_button_button_up():
	if get_parent() == get_tree().root:
		$SFX.stream = click_sound
		$SFX.play()
	else:
		$".."/SFX.stream = click_sound
		$".."/SFX.play()
	MenuHandler.remove_options()
# Changes the display mode
func _on_option_button_item_selected(index):
	$SFX.stream = click_sound
	$SFX.play()

	window_mode_to_int(DisplayServer.window_get_mode())
	
	match index:
		0:
			if windowed == "max":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	ConfigHandler.save_video_setting("display_mode", DisplayServer.window_get_mode())

# Changes the sound levels from sound sliders
func _on_main_slider_value_changed(value):
	AudioServer.set_bus_volume_db(main_bus, linear_to_db(value))
	ConfigHandler.save_audio_setting("main", value)
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	ConfigHandler.save_audio_setting("music", value)
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	ConfigHandler.save_audio_setting("sfx", value)
# Play sound effect when changing sound levels
func _on_main_slider_drag_ended(value_changed):
	$SFX.stream = click_sound
	$SFX.play()
func _on_music_slider_drag_ended(value_changed):
	$SFX.stream = click_sound
	$SFX.play()
func _on_sfx_slider_drag_ended(value_changed):
	$SFX.stream = click_sound
	$SFX.play()

# Pulls the current display mode and returning an index for options button
func window_mode_to_int(mode):
	match mode:
		0:
			windowed = "windowed"
			return 0
		2:
			windowed = "max"
			return 0
		4:
			return 1
		3:
			return 2
