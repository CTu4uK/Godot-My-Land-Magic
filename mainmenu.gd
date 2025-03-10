extends Control

func _on_новая_игра_pressed():
	print("Нажата кнопка 'Новая игра'")  # Проверка в консоли
	get_tree().change_scene_to_file("res://node_2d.tscn")  # Загружаем сцену игры
