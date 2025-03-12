extends Control

@onready var population_label = $ResourcePanel/PopulationLabel
@onready var food_label = $ResourcePanel/FoodLabel
@onready var wood_label = $ResourcePanel/WoodLabel
@onready var gold_label = $ResourcePanel/GoldLabel
@onready var rumors_label = $RumorsPanel/RumorsLabel
@onready var quest_panel = $QuestPanel
@onready var close_button = $CloseButton

# Стартовые параметры деревни
var population = 3
var population_limit = 52
var loyalty = 100  # Пока не используется, но добавляем

var food = 0
var wood = 0
var gold = 0

var food_income = 1
var wood_income = 1
var gold_income = 1

# Флаг для состояния окна
var is_visible = false

func _ready():
	visible = false
	close_button.pressed.connect(_on_close_pressed)

	# Запуск обновлений
	start_timers()
	
	# Отображаем начальные значения в UI
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
	# Таймер для ресурсов (раз в минуту)
	var resource_timer = Timer.new()
	resource_timer.wait_time = 60.0
	resource_timer.autostart = true
	resource_timer.connect("timeout", _on_resource_update)
	add_child(resource_timer)

	# Таймер для слухов (раз в 2 минуты)
	var rumor_timer = Timer.new()
	rumor_timer.wait_time = 120.0
	rumor_timer.autostart = true
	rumor_timer.connect("timeout", _on_rumor_update)
	add_child(rumor_timer)

	# Таймер для населения (раз в 15 минут)
	var population_timer = Timer.new()
	population_timer.wait_time = 900.0  # 15 минут
	population_timer.autostart = true
	population_timer.connect("timeout", _on_population_update)
	add_child(population_timer)

# **Функция обновления ресурсов**
func _on_resource_update():
	food += food_income
	wood += wood_income
	gold += gold_income
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


func _on_village_button_pressed() -> void:
	pass # Replace with function body.


func _on_close_button_pressed() -> void:
	pass # Replace with function body.
