extends Node2D

# Particle references
@onready var fx_sprite: Sprite2D = $FxSprite
@onready var death_particle_2: CPUParticles2D = $"Death_Particle2"
@onready var death_particle: CPUParticles2D = $"Death_Particle"
@onready var wing: CPUParticles2D = $"BodyExplode/Wing"
@onready var sting: CPUParticles2D = $"BodyExplode/Sting"
@onready var head: CPUParticles2D = $"BodyExplode/Head"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func particles():
	animation_player.play("death")
	fx_sprite.rotate(deg_to_rad(randi_range(0, 360)))
	death_particle.emitting = true
	death_particle_2.emitting = true
	wing.emitting = true
	sting.emitting = true
	head.emitting = true
