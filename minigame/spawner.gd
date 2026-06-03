extends Node2D

var spawn_x := 340
var spawn_y := [64, 207]

@export var enemy_formations: Array[PackedScene]

func _on_timer_timeout() -> void:
	inst(enemy_formations.pick_random())

func inst(scene):
	var instance = scene.instantiate()
	instance.global_position = Vector2(spawn_x, randi_range(spawn_y[0], spawn_y[1]))
	add_child(instance)
