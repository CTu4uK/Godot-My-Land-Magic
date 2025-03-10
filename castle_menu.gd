extends Control

@onready var castle_button = get_parent().find_child("CastleButton", true, false)  # Кнопка для открытия меню
@onready var menu = get_parent().find_child("Castlemenu", true, false)   # Само меню
@onready var close_button = get_parent().find_child("Закрыть", true, false)  # Кнопка закрытия

func _ready():
	# Проверяем, найдены ли узлы
	if menu:
		menu.call_deferred("set_visible", false)  # Скрываем меню при старте
		print("Меню замка найдено.")
	else:
		print("Ошибка: CastleMenu не найден!")

	if castle_button:
		castle_button.pressed.connect(_on_castle_button_pressed)
		print("Кнопка замка найдена.")
	else:
		print("Ошибка: CastleButton не найден!")

	if close_button:
		close_button.pressed.connect(_on_close_pressed)
		print("Кнопка закрытия найдена.")
	else:
		print("Ошибка: CloseButton не найден!")

func _on_castle_button_pressed():
	print("Кнопка нажата!")  
	print("menu:", menu)  # Проверяем, что menu существует
	if menu:
		menu.visible = !menu.visible  
		print("Состояние меню:", menu.visible)  # Проверяем, изменяется ли оно

func _on_close_pressed():
	if menu:
		menu.visible = false  # Закрываем меню
		print("Меню замка закрыто.")


func _on_закрыть_pressed() -> void:
	pass # Replace with function body.
