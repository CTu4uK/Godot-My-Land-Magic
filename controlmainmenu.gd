func _on_новая_игра_pressed():
	var game_scene = load("res://node_2d.tscn")  # Проверь путь!
	if game_scene:
		get_tree().change_scene_to_packed(game_scene)
	else:
		print("Ошибка: сцена не загружена!")
