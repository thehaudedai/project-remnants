extends CharacterBody2D

# -------------------------------------------------------------------------------
# Game Elements
@onready var explosion_effect: CPUParticles2D = $Particles/ExplosionEffect
@onready var trail_effect: CPUParticles2D = $Particles/TrailEffect
@onready var orb_light: PointLight2D = $OrbLight
@onready var flicker_timer: Timer = $OrbLight/FlickerTimer

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var explosion_effect_timer: Timer = $Particles/ExplosionEffect/ExplosionEffectTimer


# Variables + Constants
const baseSPEED = 350
const RIGHT_BOUND = 1600
const LOWER_BOUND = 900

var SPEED = baseSPEED
var current_stage = 1
var can_move = true
var flicker_base_energy = 1.0
var is_flickering = false

# Signal
signal blue_orb_shattered
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func _physics_process(_delta: float) -> void:
	# Enable/Disbale Movement		
	if can_move:
		# Movement Mechanics
		var direction = Vector2.ZERO
		if Input.is_action_pressed("blue_up"):
			direction.y -= SPEED
		if Input.is_action_pressed("blue_down"):
			direction.y += SPEED
		if Input.is_action_pressed("blue_right"):
			direction.x += SPEED	
		if Input.is_action_pressed("blue_left"):
			direction.x -= SPEED
		if direction != Vector2.ZERO:
			direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	if velocity.length() > 0:
		var dir = -velocity.normalized()  # Opposite direction of movement
		trail_effect.direction = dir
		trail_effect.emitting = true
	else:
		trail_effect.emitting = false
	
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
		orb_light.energy = 1
		stop_flicker()
		current_stage = 1
	elif stage_number == 2:
		SPEED = baseSPEED + baseSPEED*0.5
		scale = Vector2(0.7, 0.7)
		orb_light.energy = 0.7
		stop_flicker()
		current_stage = 2
	elif stage_number == 3:
		SPEED = baseSPEED + baseSPEED*0.75
		scale = Vector2(0.5, 0.5)
		orb_light.energy = 0.4
		start_flicker()
		current_stage = 3
	elif stage_number == 4:
		explosion_effect.emitting = true
		explosion_effect_timer.start(1)
		can_move = false
		sprite_2d.visible = false
		collision_shape_2d.disabled = true
		stop_flicker()
		orb_light.enabled = false
		current_stage = 4
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func apply_damage():
	apply_stage(current_stage+1)
	
func apply_heal():
	apply_stage(current_stage-1)
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func start_flicker():
	if is_flickering:
		return
	is_flickering = true
	flicker_base_energy = orb_light.energy
	flicker_timer.start()
	
func stop_flicker():
	is_flickering = false
	flicker_timer.stop()
	orb_light.energy = flicker_base_energy
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func _on_flicker_timer_timeout() -> void:
	if not is_flickering:
		return
	
	var flicker_energy = randf_range(0, 0.4)	
	orb_light.energy = clamp(flicker_base_energy + flicker_energy, 0.2, 2.0)
	orb_light.enabled = !orb_light.enabled
# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
func _on_explosion_effect_timer_timeout() -> void:
	emit_signal("blue_orb_shattered")
# -------------------------------------------------------------------------------
