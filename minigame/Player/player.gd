extends CharacterBody2D

@export var jump_velocity: float
@export var gravity: float
@export var glide_velocity: float
@export var bullet: PackedScene
@export var particle: PackedScene

@onready var camera_2d: Camera2D = %Camera2D

func _ready() -> void:
	Global.connect("game_over", game_over)

func _physics_process(_delta: float) -> void:
	if Global.is_game_over == false:
		if Input.is_action_just_pressed("jump"):
			if velocity.y >= 0:
				camera_2d.shake(3, 4)
				inst(bullet)
			velocity.y = -jump_velocity
		#if Input.is_action_just_pressed("shoot"):
		#	inst(bullet)
		if Input.is_action_pressed("jump") and velocity.y >= 0:
			velocity.y = glide_velocity
		else:
			if velocity.y > 0:
				velocity.y += gravity * 1.3
			else:
				velocity.y += gravity
		#rotation = deg_to_rad(velocity.y) * 0.05
		move_and_slide()

func inst(scene):
	var instance = scene.instantiate()
	instance.global_position = global_position + Vector2(8, 0)
	add_sibling(instance)

func game_over():
	hide()
