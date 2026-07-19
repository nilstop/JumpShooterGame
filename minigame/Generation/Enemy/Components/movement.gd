extends Node2D

@onready var p := get_parent()
@export var bounce_offset := 0.0
@export var bounce_amp := 1.0
@export var bounce_freq := 1.0

var start_y_pos: float

func _ready() -> void:
	start_y_pos = p.global_position.y

func _physics_process(_delta: float) -> void:
	# Bounce
	p.global_position.x -= Global.speed
	bounce_offset = sin(p.global_position.x * bounce_freq) * bounce_amp
	p.global_position.y = start_y_pos + bounce_offset
