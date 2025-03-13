extends Button

@onready var mine_menu = $"../Mine"
@onready var button_sound = $StoneMine/Mine/TextureRect/ButtonSound2

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if mine_menu:
		mine_menu.visible = true  # Открываем меню
		mine_menu.update_info()  # Обновляем информацию
		button_sound.play()
