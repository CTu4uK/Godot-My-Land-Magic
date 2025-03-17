extends Button

@onready var village_menu = $"../VillageMenu"  # Подключаем меню деревни
@onready var button_sound = $ButtonSound3  # Подключаем новый звук

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if village_menu:
		village_menu.visible = true  # Открываем меню
		village_menu.update_info()  # Обновляем информацию

		# **Проигрываем звук при нажатии**
		if button_sound:
			button_sound.play()
