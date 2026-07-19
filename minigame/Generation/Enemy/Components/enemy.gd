extends Area2D

@onready var sprite: AnimatedSprite2D = $Sprite

@export var damage_node: Node2D

func _ready() -> void:
	sprite.frame = randi_range(0, 6)



func _on_area_entered(area: Area2D) -> void:
	damage_node.hit(area)
