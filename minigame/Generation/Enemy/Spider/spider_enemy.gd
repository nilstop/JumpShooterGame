extends Area2D


@export var damage_node: Node2D
@export var enter_at : Vector2
@export var enter_range: float
@export var sway_distance : float
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var string: Line2D = $String

var spider := true
var swing := true
var public_tween: Tween

func _ready() -> void:
	enter()
	for i in string.points.size():
		if i != 6: 
			string.points[i].x = randf_range(-1.0, 1.0)

func _process(delta: float) -> void:
	print(global_position)

func _on_area_entered(area: Area2D) -> void:
	damage_node.hit(area)

func enter():
	var tween = create_tween()
	tween.tween_property(self, "global_position", enter_at + Vector2(randf_range(-enter_range, enter_range), 0)
	, 1.0).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	public_tween = tween
	await tween.finished
	animation.play("spiderspawn")
	
	
func sway_up():
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0, -sway_distance), 1.75).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	public_tween = tween

func sway_down():
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0,sway_distance), 1.75).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	public_tween = tween

func string_leave():
	var tween = create_tween()
	tween.tween_property(string, "global_position", 
	Vector2(global_position.x, global_position.y/2), 0.7).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(string, "global_position", 
	Vector2(global_position.x, 0), 1.8).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)

func death():
	public_tween.kill()
	animation.play("death")
