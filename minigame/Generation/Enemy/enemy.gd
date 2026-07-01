extends Area2D

@onready var color_rect: ColorRect = $ColorRect
@onready var score_label := get_tree().get_first_node_in_group("score_label")
@onready var death_particle: CPUParticles2D = $Death_Particle
@onready var camera_2d: Camera2D = %Camera2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _physics_process(_delta: float) -> void:
	global_position.x -= Global.speed

func _on_area_entered(area: Area2D) -> void:
	print("collission")
	if area.is_in_group("bullet"):
		# fx and destroy when hit
		monitoring = false
		monitorable = false
		collision_shape.disabled = true
		collision_shape.queue_free()
		var color = color_rect.color
		#color_rect.color = Color.WHITE
		area.queue_free()
		death_particle.emitting = true
		#for i in 3:
		#	color_rect.position = Vector2(randi_range(-8,-0), randi_range(-8,-0))
		#	await get_tree().create_timer(0.07).timeout
		#	color_rect.color = color
		Global.score += 1000
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
