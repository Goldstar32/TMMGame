extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_up():
	#Byt scen till nästa
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_up():
	#Stänger ned programmet
	get_tree().quit()


func _on_options_button_up():
	#Lägger till transitionscenen till main menu
	var options = preload("res://Scenes/Menus/options_menu.tscn").instantiate()
	get_tree().get_root().add_child(options)
