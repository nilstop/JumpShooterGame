extends Area2D

@onready var color_rect: ColorRect = $ColorRect
@onready var score_label := get_tree().get_first_node_in_group("score_label")
@onready var death_particle: CPUParticles2D = $Death_Particle
@onready var death_particle_2: CPUParticles2D = $Death_Particle2
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fx_sprite: Sprite2D = $FxSprite
@onready var camera_2d: Camera2D = get_tree().get_first_node_in_group("camera")

var start_y_pos: float
var bounce_offset := 0.0
var bounce_amp := 1.0
var bounce_freq := 1.0

func _ready() -> void:
	start_y_pos = global_position.y

func _physics_process(_delta: float) -> void:
	global_position.x -= Global.speed
	bounce_offset = sin(global_position.x * bounce_freq) * bounce_amp
	global_position.y = start_y_pos + bounce_offset

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		# fx and destroy when hit
		animation_player.play("death")
		fx_sprite.rotate(deg_to_rad(randi_range(0, 360)))
		camera_2d.shake(3, 4)
		monitoring = false
		monitorable = false
		#collision_shape.disabled = true
		collision_shape.queue_free()
		#var color = color_rect.color
		#color_rect.color = Color.WHITE
		area.queue_free()
		death_particle.emitting = true
		death_particle_2.emitting = true
		#for i in 3:
		#	color_rect.position = Vector2(randi_range(-8,-0), randi_range(-8,-0))
		#	await get_tree().create_timer(0.07).timeout
		#	color_rect.color = color
		Global.score += 20
		score_label.text = str(Global.score)
		color_rect.hide()

		#get_tree().get_first_node_in_group("camera").shake(3)
		await death_particle.finished
		queue_free()
		
	elif area.is_in_group("barrier"):
		# Game over when touching barrier
		print("game_over")
		Global.is_game_over = true
		Global.emit_signal("game_over")
		Global.speed = 0

#func inst(scene):
	#var instance = scene.instantiate()
	#instance.global_position = global_position
	#add_sibling(instance)
