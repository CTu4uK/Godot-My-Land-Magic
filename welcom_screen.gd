extends Control

func _ready():
	visible = true  # Окно показывается при старте

func _on_продолжить_pressed():
	print("Кнопка нажата!")  # Проверяем, работает ли нажатие
	visible = false  # Скрываем окно
# Воспроизводим звук (убедись, что в дереве есть узел AudioStreamPlayer)
	$ButtonSound1.play()
