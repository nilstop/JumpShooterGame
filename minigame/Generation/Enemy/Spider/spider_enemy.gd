extends Area2D

@export var damage_node: Node2D
@export var enter_at : Vector2
@export var sway_distance : float
@onready var animation: AnimationPlayer = $AnimationPlayer

var spider := true
var swing := true

func _ready() -> void:
	enter()
	
func _process(delta: float) -> void:
	print(global_position)

func _on_area_entered(area: Area2D) -> void:
	damage_node.hit(area)

func enter():
	var tween = create_tween()
	tween.tween_property(self, "global_position", enter_at, 1.0).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	await tween.finished
	animation.play("spiderspawn")
	
func sway_up():
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0, -sway_distance), 1.75).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func sway_down():
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(0,sway_distance), 1.75).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
