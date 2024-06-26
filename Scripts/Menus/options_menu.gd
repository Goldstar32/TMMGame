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
	var main_slider = $MenuPanel/MarginContainer/VBoxContainer/Content/SoundOptions/GridContainer2/MainSlider
	main_slider.value = db_to_linear(AudioServer.get_bus_volume_db(main_bus))
	var music_slider = $MenuPanel/MarginContainer/VBoxContainer/Content/SoundOptions/GridContainer2/MusicSlider
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	var sfx_slider = $MenuPanel/MarginContainer/VBoxContainer/Content/SoundOptions/GridContainer2/SFXSlider
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))
	
	var mode_option_button = $MenuPanel/MarginContainer/VBoxContainer/Content/OtherOptions/Mode
	var window_mode = window_mode_to_int()
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

	window_mode_to_int()
	
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

# Changes the sound levels from sound sliders
func _on_main_slider_value_changed(value):
	AudioServer.set_bus_volume_db(main_bus, linear_to_db(value))
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
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
func window_mode_to_int():
	var mode = DisplayServer.window_get_mode()
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
