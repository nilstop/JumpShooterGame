extends Node2D

# Particle references
@onready var fx_sprite: Sprite2D = $FxSprite
@onready var death_particle_2: CPUParticles2D = $"Death_Particle2"
@onready var death_particle: CPUParticles2D = $"Death_Particle"
@onready var wing: CPUParticles2D = $"BodyExplodeBee/Wing"
@onready var sting: CPUParticles2D = $"BodyExplodeBee/Sting"
@onready var head: CPUParticles2D = $"BodyExplodeBee/Head"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = get_tree().get_first_node_in_group("camera")

@export_enum("Bee", "Spider") var enemy_type

@export var sprite: AnimatedSprite2D

func particles():
	animation_player.play("death")
	fx_sprite.rotate(deg_to_rad(randi_range(0, 360)))
	death_particle.emitting = true
	death_particle_2.emitting = true
	if enemy_type == 0:
		wing.emitting = true
		sting.emitting = true
		head.emitting = true
	if enemy_type == 1:
		pass

func hit():
	if enemy_type == 1:
		sprite.animation = "hitframe"
		death_particle.emitting = true
		death_particle_2.emitting = true
		camera_2d.shake(3, 4)
		await get_tree().create_timer(0.15).timeout
		sprite.animation = "default"
