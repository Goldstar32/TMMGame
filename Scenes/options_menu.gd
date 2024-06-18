extends Control
@onready var options_menu = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("pad_animation")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_up():
	$AnimationPlayer.play_backwards("pad_animation")
	await get_tree().create_timer(0.5).timeout
	get_tree().root.remove_child(options_menu)
