extends CharacterBody2D

const SPEED : int = 150 # speed in pixels/sec

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED

	move_and_slide()
