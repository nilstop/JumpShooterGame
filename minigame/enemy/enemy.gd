extends Area2D


@onready var color_rect: ColorRect = $ColorRect
@onready var score_label := get_tree().get_first_node_in_group("score_label")


func _physics_process(_delta: float) -> void:
	global_position.x -= Global.speed

func _on_area_entered(area: Area2D) -> void:
	color_rect.color = Color.WHITE
	area.queue_free()
	await get_tree().create_timer(0.05).timeout
	Global.score += 1000
	score_label.text = str(Global.score)
	queue_free()
