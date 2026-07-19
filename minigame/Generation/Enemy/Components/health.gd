extends Node2D

@onready var score_label := get_tree().get_first_node_in_group("score_label")
@onready var collision_shape: CollisionShape2D = $"../CollisionShape2D"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var camera_2d: Camera2D = get_tree().get_first_node_in_group("camera")

@onready var sprite: AnimatedSprite2D = $"../Sprite"
@onready var p := get_parent()



# Stats
@export var health: int

# Nodes
@export var effects: Node2D

func hit(area):
	if area.is_in_group("bullet"):
		health -= Global.player_damage
		if health <= 0:
			destroy(area)
	
	elif area.is_in_group("barrier"):
		game_over()



func game_over():
	# Game over when touching barrier
	Global.is_game_over = true
	Global.emit_signal("game_over")
	Global.speed = 0

func destroy(area):
	
	collision_shape.queue_free()
	area.queue_free()
	
	# Effects
	sprite.hide()
	effects.particles()
	camera_2d.shake(3, 4)
	
	# Score
	Global.score += 20
	score_label.text = str(Global.score)
	
	# Destroy
	await get_tree().create_timer(4.0).timeout
	queue_free()
