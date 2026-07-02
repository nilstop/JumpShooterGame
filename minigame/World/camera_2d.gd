extends Camera2D

func shake(times, intensity):
	for i in times:
		offset = Vector2(randi_range(-intensity,intensity), randi_range(-intensity,intensity))
		offset = offset / (i+1)
		await get_tree().create_timer(0.04).timeout
	offset = Vector2.ZERO
