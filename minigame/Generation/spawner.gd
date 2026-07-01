extends Node2D

var spawn_x := 180
var spawn_y := [21, 99]



@export var enemy_formations: Array[PackedScene]
@onready var timer: Timer = $Timer

func _ready() -> void:
	Global.connect("game_over", game_over)

func _on_timer_timeout() -> void:
	inst(enemy_formations.pick_random())

func inst(scene: PackedScene):
	var instance = scene.instantiate()
	instance.global_position = Vector2(spawn_x + instance.size.x/2, randi_range(spawn_y[0] + instance.size.y/2, spawn_y[1] - instance.size.y/2))
	
	add_child(instance)

func game_over():
	timer.stop()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		if Global.is_game_over:
			for n in get_children():
				n.queue_free()
