extends Control
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")

func _ready():
	pass
func _process(delta):
	pass


func _on_resume_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	MenuHandler.unpause()

func _on_options_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	MenuHandler.add_options()

func _on_quit_to_main_button_up():
	get_tree().paused = false
	MenuHandler.pause_menu_instance = null
	
	$SFX.stream = click_sound
	$SFX.play()
	await get_tree().create_timer(0.3).timeout
	
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")


func _on_close_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	MenuHandler.unpause()

