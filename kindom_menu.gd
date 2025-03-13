extends Control

@onready var res_label = $Res
@onready var popul_label = $Popul
@onready var loy_label = $Loy
@onready var close_button = $CloseButton
@onready var button_sound = $ButtonSound3  # Добавляем переменную для звука кнопки

func _ready():
	close_button.pressed.connect(_on_close_pressed)
	close_button.pressed.connect(_on_button_sound)  # Добавляем звук при нажатии

	update_info()  # Загружаем данные при открытии

# Обновление информации о королевстве
func update_info():
	if res_label:
		res_label.text = "Еда: %d\nДерево: %d\nКамень: %d\nЗолото: %d" % [
			GlobalResources.food, GlobalResources.wood, GlobalResources.gold
		]

	if popul_label:
		popul_label.text = "Население: %d" % GlobalResources.population

	if loy_label:
		loy_label.text = "Лояльность: %d" % GlobalResources.loyalty

# **Функция закрытия меню**
func _on_close_pressed():
	visible = false

# **Функция воспроизведения звука**
func _on_button_sound():
	button_sound.play()
