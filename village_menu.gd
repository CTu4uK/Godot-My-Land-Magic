extends Control

@onready var population_label = $ResourcePanel/PopulationLabel
@onready var food_label = $ResourcePanel/FoodLabel
@onready var wood_label = $ResourcePanel/WoodLabel
@onready var gold_label = $ResourcePanel/GoldLabel
@onready var rumors_label = $RumorsPanel/RumorsLabel
@onready var quest_panel = $QuestPanel
@onready var close_button = $CloseButton
@onready var button_sound = $ButtonSound2
@onready var collect_button = $CollectButton  # Кнопка сбора ресурсов

# **Параметры деревни**
var population = 3
var population_limit = 52
var loyalty = 100  

var food = 0
var wood = 0
var gold = 0

var food_income = 1
var wood_income = 1
var gold_income = 1

# Таймеры
var resource_timer: Timer
var rumor_timer: Timer
var population_timer: Timer

# **Запуск игры**
func _ready():
	visible = false
	close_button.pressed.connect(_on_close_pressed)
	collect_button.pressed.connect(_on_collect_resources)  

	start_timers()
	update_info()

	# **Первый слух при старте**
	_on_rumor_update()

# **Функция обновления UI**
func update_info():
	if population_label:
		population_label.text = "Население: %d/%d" % [population, population_limit]

	if food_label:
		food_label.text = "Еда: %d" % food

	if wood_label:
		wood_label.text = "Дерево: %d" % wood

	if gold_label:
		gold_label.text = "Золото: %d" % gold

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
		rumor_timer.wait_time = 120.0  # Слухи обновляются раз в 2 минуты
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

# **Функция генерации слухов**
func generate_rumor():
	var rumors = [
		"Слухи ходят, что мельник нашел клад!",
		"Купец привез странные амулеты с востока.",
		"Старая ведьма из леса ищет себе ученика.",
		"Говорят, кузнец влюбился в дочь старосты.",
		"Жители жалуются, что ночью видели огненный шар в небе!",
		"На постоялом дворе появился странный путник...",
		"В трактире говорят, что волки стали нападать на стада.",
		"Горожане слышали крики из заброшенного дома...",
		"Купец привез редкие специи из дальних земель.",
		"Фермеры замечают, что урожай стал хуже обычного."
	]
	return rumors[randi() % rumors.size()]

# **Функция обновления слухов (по таймеру)**
func _on_rumor_update():
	if rumors_label:
		var new_rumor = generate_rumor()
		print("Новый слух:", new_rumor)  # Логируем слухи в консоли
		rumors_label.text = new_rumor

# **Функция обновления ресурсов**
func _on_resource_update():
	food += food_income
	wood += wood_income
	gold += gold_income

	update_info()

# **Функция сбора ресурсов (Кнопка в меню)**
func _on_collect_resources():
	print("Собрано ресурсов: Еда %d, Дерево %d, Золото %d" % [food, wood, gold])
	button_sound.play()

	# Передача ресурсов в общий пул
	GlobalResources.food += food
	GlobalResources.wood += wood
	GlobalResources.gold += gold

	# Обнуляем ресурсы деревни
	food = 0
	wood = 0
	gold = 0

	update_info()

# **Функция увеличения населения**
func _on_population_update():
	if population < population_limit:
		population += 1
		update_info()

# **Закрываем меню**
func _on_close_pressed():
	visible = false
	button_sound.play()

# **Функция звука кнопки**
func _on_village_button_pressed():
	button_sound.play()
