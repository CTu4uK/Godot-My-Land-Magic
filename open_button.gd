extends Button

@onready var kindom_menu = $"../KindomMenu"

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if kindom_menu:
		kindom_menu.visible = true  # Открываем меню
		kindom_menu.update_info()   # Обновляем информацию
