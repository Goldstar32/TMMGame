extends Control
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	#Byt scen till nästa
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	#Stänger ned programmet
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()


func _on_options_button_up():
	$SFX.stream = click_sound
	$SFX.play()
	
	#Lägger till optionsscenen till main menu
	var options = preload("res://Scenes/Menus/options_menu.tscn").instantiate()
	get_tree().get_root().add_child(options)
