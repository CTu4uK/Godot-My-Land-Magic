extends Control

@onready var population_label = $TextureRect/Popul
@onready var stone_label = $TextureRect/Stone
@onready var rumors_label = $TextureRect/Rumors
@onready var close_button = $CloseButton
@onready var button_sound = $TextureRect/ButtonSound2

# **Параметры каменоломни**
var population = 3
var population_limit = 12
var stone = 0
var stone_income = 2  # Добыча камня

# Таймеры
var resource_timer: Timer
var rumor_timer: Timer
var population_timer: Timer

func _ready():
	visible = false
	close_button.pressed.connect(_on_close_pressed)

	start_timers()
	update_info()

# **Функция обновления UI**
func update_info():
	if population_label:
		population_label.text = "Население: %d/%d" % [population, population_limit]

	if stone_label:
		stone_label.text = "Камень: %d" % stone

	if rumors_label:
		rumors_label.text = generate_rumor()

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
		population_timer.wait_time = 300.0  
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
	print("Собрано ресурсов: Камень %d" % stone)

	# Передача камня в общий пул
	GlobalResources.stone += stone

	# Обнуляем ресурс каменоломни
	stone = 0

	update_info()

# **Функция обновления слухов**
func _on_rumor_update():
	if rumors_label:
		rumors_label.text = generate_rumor()

# **Функция увеличения населения**
func _on_population_update():
	if population < population_limit:
		population += 1
		update_info()

# **Функция генерации слухов про каменоломню**
func generate_rumor():
	var rumors = [
		"Рабочие говорят, что нашли странный артефакт среди камней.",
		"Люди замечают, что камень стал крошиться сильнее обычного.",
		"Ходят слухи, что в пещерах под каменоломней что-то живёт...",
		"Кто-то слышал, как ночью рабочие переговариваются о чём-то тайном.",
		"Несколько каменщиков жалуются на странные сны после работы.",
		"Рабочий убежал, крича, что видел призрака среди скал.",
		"Легенда гласит, что древний монолит закопан под каменоломней...",
		"Купцы интересуются камнем из этой местности, говорят, он особенный.",
		"Старая ведьма предупреждала, что копать здесь опасно.",
		"Местные считают, что камень здесь когда-то был частью великого храма."
	]
	return rumors[randi() % rumors.size()]

# **Закрываем меню**
func _on_close_pressed():
	visible = false
	button_sound.play()


func _on_openbutton_pressed() -> void:
	pass # Replace with function body.
