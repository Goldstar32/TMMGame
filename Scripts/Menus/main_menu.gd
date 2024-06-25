extends Control
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	# Change scene to TestLevel
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Testing/test_level.tscn")


func _on_quit_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	# Shuts down the program
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_options_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	# Adds the options scene to main menu scene
	var options = preload("res://Scenes/Menus/options_menu.tscn").instantiate()
	options.menu_from_main_menu()
	get_tree().get_root().add_child(options)
