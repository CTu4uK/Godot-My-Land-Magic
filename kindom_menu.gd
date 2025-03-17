extends Control 

@onready var res_label = $Res
@onready var popul_label = $Popul
@onready var loy_label = $Loy
@onready var close_button = $CloseButton
@onready var button_sound = $ButtonSound3  

# ✅ Вручную задаем стартовое население замка
var manual_start_population = 6  

func _ready():
	close_button.pressed.connect(_on_close_pressed)
	close_button.pressed.connect(_on_button_sound)

	# ✅ Подписываемся на сигнал глобальных ресурсов
	GlobalResources.connect("population_updated", Callable(self, "_update_population"))

	update_info()  

# **Обновление информации о королевстве**
func update_info():
	if res_label:
		res_label.text = "Еда: %d\nДерево: %d\nКамень: %d\nЗолото: %d" % [
			GlobalResources.food, GlobalResources.wood, GlobalResources.stone, GlobalResources.gold
		]

	if popul_label:
		popul_label.text = "Население: %d" % GlobalResources.population  

	if loy_label:
		loy_label.text = "Лояльность: %d" % GlobalResources.loyalty

# **Функция обновления населения при изменениях**
func _update_population(new_population):
	update_info()

# **Закрываем меню**
func _on_close_pressed():
	visible = false

# **Функция звука кнопок**
func _on_button_sound():
	button_sound.play()
