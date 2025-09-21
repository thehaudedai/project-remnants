extends CharacterBody2D


const SPEED = 350
const RIGHT_BOUND = 1600
const LOWER_BOUND = 900


func _physics_process(_delta: float) -> void:
	
	var direction = Vector2.ZERO
	if Input.is_action_pressed("green_up"):
		direction.y -= SPEED
	if Input.is_action_pressed("green_down"):
		direction.y += SPEED
	if Input.is_action_pressed("green_right"):
		direction.x += SPEED	
	if Input.is_action_pressed("green_left"):
		direction.x -= SPEED
		
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	velocity = direction * SPEED
	
	move_and_slide()
	
	var diameter = get_radius() * 2
	position.x = clamp(position.x, 0, RIGHT_BOUND - diameter)
	position.y = clamp(position.y, 0, LOWER_BOUND - diameter)
	
func get_radius():
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		return shape.radius
	else:
		print("Warning: Unsupported shape used for boundary clamping.")
		return 100
