extends CharacterBody2D

# -------------------------------------------------------------------------------
# Game Elements


# Variables + Constants
const baseSPEED = 350
const RIGHT_BOUND = 1600
const LOWER_BOUND = 900

var SPEED = baseSPEED
var current_stage = 1
var can_move = true

# Signal
signal green_orb_shattered
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	# Enable/Disbale Movement
	if not can_move:
		velocity = Vector2.ZERO
		return
	# -------------------------------------------------------------------------------
	# Movement Mechanics
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
	# -------------------------------------------------------------------------------
	# Border Mechanics
	var diameter = get_radius() * 2
	position.x = clamp(position.x, 0, RIGHT_BOUND - diameter)
	position.y = clamp(position.y, 0, LOWER_BOUND - diameter)
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
# Radius of the Character
func get_radius():
	var shape = $CollisionShape2D.shape
	if shape is CircleShape2D:
		return shape.radius
	else:
		print("Warning: Unsupported shape used for boundary clamping.")
		return 100
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func apply_stage(stage_number):
	if stage_number == 1:
		SPEED = baseSPEED
		scale = Vector2(1, 1)
		current_stage = 1
	elif stage_number == 2:
		SPEED = baseSPEED + baseSPEED*0.5
		scale = Vector2(0.7, 0.7)
		current_stage = 2
	elif stage_number == 3:
		SPEED = baseSPEED + baseSPEED*0.75
		scale = Vector2(0.5, 0.5)
		current_stage = 3
	elif stage_number == 4:
		queue_free()
		emit_signal("green_orb_shattered")
		current_stage = 4
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func apply_damage():
	apply_stage(current_stage+1)
	
func apply_heal():
	apply_stage(current_stage-1)
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------

# -------------------------------------------------------------------------------
