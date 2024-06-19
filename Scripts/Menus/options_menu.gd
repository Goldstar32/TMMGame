extends Control
@onready var options_menu = $"."
@onready var click_sound = preload("res://Assets/SFX/spacebar-click-keyboard-199448.mp3")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_up():
	$AudioStreamPlayer2D.stream = click_sound
	$AudioStreamPlayer2D.play()
	
	get_tree().root.remove_child(options_menu)
