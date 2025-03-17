extends Control

@onready var population_label = $TextureRect/Popul
@onready var stone_label = $TextureRect/Stone
@onready var rumors_label = $TextureRect/Rumors
@onready var close_button = $CloseButton
@onready var collect_button = $TextureRect/CollectButton2
@onready var button_sound = $TextureRect/ButtonSound2

signal population_updated  # ✅ Добавляем сигнал

# **Стартовые параметры каменоломни**
var population = 3
var population_limit = 12
var stone = 0
var stone_income = 2  

# Таймеры
var resource_timer: Timer
var rumor_timer: Timer
var population_timer: Timer
var current_rumor: String  # Переменная для хранения текущего слуха

func _ready():
	visible = false
	if GlobalResources.population == 3:
		GlobalResources.population += population
		
	if close_button:
		close_button.pressed.connect(_on_close_pressed)
		close_button.pressed.connect(_on_button_sound)

	if collect_button:
		collect_button.pressed.connect(_on_collect_resources)
		collect_button.pressed.connect(_on_button_sound)

	start_timers()
	_on_rumor_update()  # Принудительно обновляем слухи при открытии окна
	_sync_population_to_global()  # Передаем население в общий пул
	update_info()

# **Функция обновления UI**
func update_info():
	if population_label:
		population_label.text = "Население: %d/%d" % [population, population_limit]

	if stone_label:
		stone_label.text = "Камень: %d" % stone

	if rumors_label:
		rumors_label.text = current_rumor  # Используем сохраненный слух
		rumors_label.autowrap_mode = TextServer.AUTOWRAP_WORD  # Обеспечиваем перенос слов

# **Функция передачи населения в общий пул**
func _sync_population_to_global():
	if GlobalResources.population < population:
		GlobalResources.population += population  # ✅ Добавляем население в общий пул
	update_info()

# **Функция запуска таймеров**
func start_timers():
	if resource_timer == null:
		resource_timer = Timer.new()
		resource_timer.wait_time = 10.0  
		resource_timer.autostart = true
		resource_timer.timeout.connect(_on_resource_update)
		add_child(resource_timer)
		resource_timer.start()

	if rumor_timer == null:
		rumor_timer = Timer.new()
		rumor_timer.wait_time = 120.0  
		rumor_timer.autostart = true
		rumor_timer.timeout.connect(_on_rumor_update)
		add_child(rumor_timer)
		rumor_timer.start()

	if population_timer == null:
		population_timer = Timer.new()
		population_timer.wait_time = 60.0  # Обновляем население раз в 60 секунд
		population_timer.autostart = true
		population_timer.timeout.connect(_on_population_update)
		add_child(population_timer)
		population_timer.start()

# **Функция обновления ресурсов**
func _on_resource_update():
	stone += stone_income
	update_info()

# **Функция сбора камня**
func _on_collect_resources():
	print("Собрано камня: %d" % stone)

	GlobalResources.stone += stone
	stone = 0
	update_info()

# **Функция обновления слухов (теперь только по таймеру)**
func _on_rumor_update():
	print("Обновляем слухи...")  # ✅ Проверяем, вызывается ли эта функция
	current_rumor = generate_rumor()  # Генерируем слух один раз и сохраняем
	update_info()  # Обновляем интерфейс, чтобы отобразить новый слух

# **Функция увеличения населения**
func _on_population_update():
	if population < population_limit:
		population += 1
		GlobalResources.update_population()  # ✅ Теперь вызываем обновление населения
		print("[DEBUG] Население шахты:", population)
		update_info()



# **Функция возвращает население шахты**
func get_population() -> int:
	print("[DEBUG] Запрос населения шахты:", population)  # ✅ Лог
	return population

# **Функция генерации слухов**
func generate_rumor():
	var rumors = [
		"Купцы интересуются камнем из этой местности, говорят, он особенный.",
		"Рабочие жалуются, что камень стал тяжелее добывать, но его цена выросла.",
		"Говорят, в шахтах находят старые руны, но никто не знает, что они значат.",
		"В одной из заброшенных шахт слышны странные звуки. Некоторые боятся туда идти.",
		"Местный торговец предлагает купить камень по выгодной цене, но только сегодня."
	]
	return rumors[randi() % rumors.size()]

# **Закрываем меню**
func _on_close_pressed():
	visible = false

# **Функция звука кнопок**
func _on_button_sound():
	if button_sound:
		button_sound.play()
