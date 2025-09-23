extends Area2D

# ------------------------------------------------------------------------------
# Game Elements


# Variables + Constants
var SPEED = 400
const RIGHT_BOUND = 1600
const LOWER_BOUND = 900
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
func _ready() -> void:
	pass # Replace with function body.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
func _process(delta: float) -> void:
	# Movement Mechanics
	var velocity = Vector2(cos(rotation), sin(rotation))
	position.x += SPEED * delta * velocity.x
	position.y += SPEED * delta * velocity.y
	# ------------------------------------------------------------------------------
	
	# If Pulse out of Border: queue_free()
	if outside_border():
		queue_free()
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Checks if Pulse is out of the Screen: BOOLEAN
func outside_border():
	if position.x < -150 or position.x > (RIGHT_BOUND+150) or position.y < -150 or position.y > (LOWER_BOUND+150):
		return true
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Damages the object;
	# If Character: Deals Damage
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("apply_damage"):
		body.apply_damage()
		queue_free()
	# ------------------------------------------------------------------------------
	# If Fragment: Destroys Fragment -> body.queue_free()
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("self_destroy"):
		area.self_destroy()
		#area.queue_free()
# ------------------------------------------------------------------------------
