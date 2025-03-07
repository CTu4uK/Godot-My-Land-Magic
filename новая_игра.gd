func _on_Button_pressed():
	var game_scene = load("res://node_2d.tscn")  # Убедись, что путь верный
	get_tree().change_scene_to_packed(game_scene)
