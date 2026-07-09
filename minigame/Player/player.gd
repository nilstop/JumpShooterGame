extends CharacterBody2D

@export var jump_velocity: float
@export var gravity: float
@export var glide_velocity: float
@export var bullet: PackedScene
@export var particle: PackedScene
@export var gunsplosion: PackedScene
@export var jump_fx: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = %Camera2D


func _ready() -> void:
	Global.connect("game_over", game_over)

func _physics_process(_delta: float) -> void:
	if Global.is_game_over == false:
		if Input.is_action_just_pressed("jump"):
			if velocity.y >= 0:
				camera_2d.shake(4, 1)
				inst(bullet, Vector2(8, -4))
				inst(gunsplosion, Vector2(10, -4))
				inst(jump_fx, Vector2(0, 2))
				animation_player.stop()
				animation_player.play("shump")
			velocity.y = -jump_velocity
		#if Input.is_action_just_pressed("shoot"):
		#	inst(bullet)
		if velocity.y > 0:
			velocity.y += gravity * 1.3
		else:
			velocity.y += gravity
		#rotation = deg_to_rad(velocity.y) * 0.05
		move_and_slide()

func inst(scene, offset: Vector2 = Vector2(0,0)):
	var instance = scene.instantiate()
	instance.global_position = global_position + offset
	add_sibling(instance)

func game_over():
	hide()


func _on_environment_area_body_entered(body: Node2D) -> void:
	animation_player.play("land")
