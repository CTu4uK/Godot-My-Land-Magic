extends Button

@onready var kindom_menu = $"../KindomMenu"
@onready var button_sound = $"../KindomMenu/ButtonSound3"

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if kindom_menu:
		kindom_menu.visible = true  # Открываем меню
		kindom_menu.update_info()   # Обновляем информацию
		_on_button_sound()  #Воспроизведение звука при открытии

func _on_button_sound():
	if button_sound:
		button_sound.play()
	else:
		print("Кнопка не найдена")
