extends Area2D

@export var speed: float

func _physics_process(_delta: float) -> void:
	global_position.x += speed
	if global_position.x > 130:
		queue_free()
