extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.set_cam($TileMap/Player/Camera2D)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
