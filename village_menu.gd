extends Control

@onready var population_label = $ResourcePanel/PopulationLabel
@onready var food_label = $ResourcePanel/FoodLabel
@onready var wood_label = $ResourcePanel/WoodLabel
@onready var gold_label = $ResourcePanel/GoldLabel
@onready var rumors_label = $RumorsPanel/RumorsLabel
@onready var quest_panel = $QuestPanel
@onready var close_button = $CloseButton
@onready var button_sound = $ButtonSound2

# **Мешочек ресурсов**
@onready var resource_bag = $"../ResourceBag"
@onready var resource_bag_button = $"../ResourceBag/Button"

# **Стартовые параметры деревни**
var population = 3
var population_limit = 52
var loyalty = 100  

var food = 0
var wood = 0
var gold = 0

var food_income = 1
var wood_income = 1
var gold_income = 1

# **Запас ресурсов в "мешочке"**
var stored_food = 0
var stored_wood = 0
var stored_gold = 0

var is_visible = false

func _ready():
	visible = false
	close_button.pressed.connect(_on_close_pressed)

	# **Подключаем кнопку сбора ресурсов**
	if resource_bag_button:
		resource_bag_button.pressed.connect(_on_collect_resources)
	else:
		print("Ошибка: Кнопка сбора ресурсов не найдена!")

	# **Скрываем мешочек при старте**
	if resource_bag:
		resource_bag.visible = false
	else:
		print("Ошибка: ResourceBag не найден!")

	# **Запуск обновлений**
	start_timers()
	update_info()

# **Функция обновления информации в UI**
func update_info():
	if population_label:
		population_label.text = "Население: %d/%d" % [population, population_limit]

	if food_label:
		food_label.text = "Еда: %d" % food

	if wood_label:
		wood_label.text = "Дерево: %d" % wood

	if gold_label:
		gold_label.text = "Золото: %d" % gold

	if rumors_label:
		rumors_label.text = generate_rumor()

# **Функция запуска таймеров**
func start_timers():
	# Таймер для ресурсов (раз в 10 сек для теста, можно увеличить)
	var resource_timer = Timer.new()
	resource_timer.wait_time = 10.0  
	resource_timer.autostart = true
	resource_timer.timeout.connect(_on_resource_update)
	add_child(resource_timer)
	resource_timer.start()

	# Таймер для слухов (раз в 2 минуты)
	var rumor_timer = Timer.new()
	rumor_timer.wait_time = 120.0  
	rumor_timer.autostart = true
	rumor_timer.timeout.connect(_on_rumor_update)
	add_child(rumor_timer)
	rumor_timer.start()

	# Таймер для населения (раз в 15 минут)
	var population_timer = Timer.new()
	population_timer.wait_time = 900.0  
	population_timer.autostart = true
	population_timer.timeout.connect(_on_population_update)
	add_child(population_timer)
	population_timer.start()

# **Функция обновления ресурсов**
func _on_resource_update():
	food += food_income
	wood += wood_income
	gold += gold_income

	# Если набралось 10 ресурсов, отправляем в "мешочек"
	if food >= 10:
		stored_food += 10
		food -= 10

	if wood >= 10:
		stored_wood += 10
		wood -= 10

	if gold >= 10:
		stored_gold += 10
		gold -= 10

	# Если есть накопленные ресурсы, показываем мешочек
	if stored_food > 0 or stored_wood > 0 or stored_gold > 0:
		if resource_bag:
			resource_bag.visible = true

	update_info()

# **Функция сбора ресурсов (клик по мешочку)**
func _on_collect_resources():
	print("Собрано ресурсов: Еда %d, Дерево %d, Золото %d" % [stored_food, stored_wood, stored_gold])

	# Добавляем к общему запасу (предполагается, что GlobalResources существует)
	if has_node("/root/GlobalResources"):
		var global_resources = get_node("/root/GlobalResources")
		global_resources.food += stored_food
		global_resources.wood += stored_wood
		global_resources.gold += stored_gold
	else:
		print("Ошибка: GlobalResources не найден!")

	# Очищаем накопленные ресурсы
	stored_food = 0
	stored_wood = 0
	stored_gold = 0

	# Скрываем мешочек
	if resource_bag:
		resource_bag.visible = false

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

# **Закрываем меню**
func _on_close_pressed():
	visible = false
	if button_sound:
		button_sound.play()

# **Функция звука для нажатий кнопки деревни**
func _on_village_button_pressed():
	if button_sound:
		button_sound.play()
