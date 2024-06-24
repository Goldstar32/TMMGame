extends CharacterBody2D

const SPEED : int = 150 # speed in pixels/sec
func handle_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED


func _physics_process(delta):
	handle_input()
	move_and_slide()
