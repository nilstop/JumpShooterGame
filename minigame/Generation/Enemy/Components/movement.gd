extends Node2D
class_name MovementComponent

@onready var p := get_parent()
@export var bounce_offset := 0.0
@export var bounce_amp := 1.0
@export var bounce_freq := 1.0
@export var speed := 0.25
@export var disable_bounce := false

var bounce_framecount := 0.0
var bounce_pos := 0.0
var start_y_pos: float


func _ready() -> void:
	start_y_pos = p.global_position.y

func _physics_process(_delta: float) -> void:
	p.global_position.x -= speed
	bounce_framecount += 1.0
	# Bounce
	bounce_pos = sin(bounce_framecount * bounce_freq) * bounce_amp
	if !disable_bounce:
		p.global_position.y = start_y_pos + bounce_pos + bounce_offset
