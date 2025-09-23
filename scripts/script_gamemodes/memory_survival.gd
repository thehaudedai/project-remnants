extends Node2D

# ------------------------------------------------------------------------------
# Game Elements
@onready var blue_orb: CharacterBody2D = $BlueOrb
@onready var green_orb: CharacterBody2D = $GreenOrb
@onready var pulse_timer: Timer = $Timers/PulseTimer


# Variables + Constants
const RIGHT_BOUND = 1600
const LOWER_BOUND = 900

var pulse_timer_range = 1
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
func _ready() -> void:
	pulse_timer.start(randf_range(1, pulse_timer_range+1))
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
func _process(_delta: float) -> void:
	pass
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
func spawn_pulse():
	# Loading the Erasure Pulse
	const erasure_pulse_scene = preload("res://scenes/game_elements/erasure_pulse.tscn")
	var erasure_pulse = erasure_pulse_scene.instantiate()
	
	# Spawn Point:
	# | 1: Top    | 2: Left    | 3: Bottom    | 4: Right    |
	var spawn_from = randi_range(1, 4)
	var spawnx = null
	var spawny = null
	
	if spawn_from == 1:
		spawnx = randi_range(0, RIGHT_BOUND)
		spawny = -80
	elif spawn_from == 2:
		spawny = randi_range(0, LOWER_BOUND)
		spawnx = -80
	elif spawn_from == 3:
		spawnx = randi_range(0, RIGHT_BOUND)
		spawny = LOWER_BOUND+80
	elif spawn_from == 4:
		spawny = randi_range(0, LOWER_BOUND)
		spawnx = RIGHT_BOUND+80
	
	# Target Point:
	var targetx = randi_range(10, RIGHT_BOUND)
	var targety = randi_range(10, LOWER_BOUND)
	
	# Getting angle:
	# Using Slope Formula: -> Int Value
	var delta_y = targety - spawny
	var delta_x = targetx - spawnx
	
	# Tan int Value: -> Angle
	var angle_radian = atan2(delta_y, delta_x)
	var angle_degree = (180 * angle_radian) / PI
	# Angle -> Rotation
	erasure_pulse.rotation_degrees = angle_degree
	
	erasure_pulse.position = Vector2(spawnx, spawny)
	return erasure_pulse
# ------------------------------------------------------------------------------


func _on_pulse_timer_timeout() -> void:
	add_child(spawn_pulse())
	pulse_timer.start(randf_range(0, pulse_timer_range))
