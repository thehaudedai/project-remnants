extends Control

@onready var death_label: Label = $Background/DeathLabel
@onready var button: Button = $Background/Button

var blue_orb: Node
var green_orb: Node


func _ready() -> void:
	visible = false
	
func _process(_delta: float) -> void:
	pass
	
func setup_orbs(blue: Node, green: Node) -> void:
	blue_orb = blue
	green_orb = green
	blue.connect("blue_orb_shattered", func(): _on_blue_orb_shattered(blue))
	green.connect("green_orb_shattered", func(): _on_green_orb_shattered(green))


func _on_blue_orb_shattered(character):
	character.queue_free()
	green_orb.can_move = false
	visible = true
	Engine.time_scale = 0.3
	death_label.text = "Blue Orb got Shattered!"

func _on_green_orb_shattered(character):
	character.queue_free()
	blue_orb.can_move = false
	visible = true
	Engine.time_scale = 0.3
	death_label.text = "Green Orb got Shattered!"


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
