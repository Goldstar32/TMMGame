extends Node

var config = ConfigFile.new()
const SETTINGS_FILE = "user://settings.ini"

var video_settings = {}
var audio_settings = {}

var main_bus_id = AudioServer.get_bus_index("Master")
var music_bus_id = AudioServer.get_bus_index("Music")
var sfx_bus_id = AudioServer.get_bus_index("SFX")

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE):
		config.set_value("video", "display_mode", 0)
		
		config.set_value("audio", "main", 1.0)
		config.set_value("audio", "music", 1.0)
		config.set_value("audio", "sfx", 1.0)
		
		config.save(SETTINGS_FILE)
	else:
		config.load(SETTINGS_FILE)
		load_video_settings()
		load_audio_settings()
	


func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE)
	
func get_video_settings():
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings
	
	
func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE)
	
func get_audio_settings():
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func load_video_settings():
	video_settings = get_video_settings()
	match video_settings.display_mode:
		0 or 2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		4:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
func load_audio_settings():
	audio_settings = get_audio_settings()
	
	AudioServer.set_bus_volume_db(main_bus_id, linear_to_db(audio_settings.main))
	AudioServer.set_bus_volume_db(music_bus_id, linear_to_db(audio_settings.music))
	AudioServer.set_bus_volume_db(sfx_bus_id, linear_to_db(audio_settings.sfx))
