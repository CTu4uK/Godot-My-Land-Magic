extends Control

@onready var population_label = $ResourcePanel/PopulationLabel
@onready var food_label = $ResourcePanel/FoodLabel
@onready var wood_label = $ResourcePanel/WoodLabel
@onready var gold_label = $ResourcePanel/GoldLabel
@onready var rumors_label = $RumorsPanel/RumorsLabel
@onready var quest_panel = $QuestsPanel
@onready var close_button = $CloseButton

# Флаг для слежения за состоянием окна
var is_visible = false

func _ready():
	# Закрываем окно при старте
	visible = false
	close_button.pressed.connect(_on_close_pressed)

# Функция обновления информации
func update_info(population, food, wood, gold):
	population_label.text = "Население: %d/%d" % [population, 52]
	food_label.text = "Еда: %d" % food
	wood_label.text = "Дерево: %d" % wood
	gold_label.text = "Золото: %d" % gold
	rumors_label.text = generate_rumor()

# Генерируем случайные слухи
func generate_rumor():
	var rumors = [
		"Соседи говорят, что лесные разбойники активизировались!",
		"Фермеры жалуются на засуху.",
		"Кузнец говорит, что скоро привезут железо из столицы.",
		"Жители обсуждают появление таинственного странника."
	]
	return rumors[randi() % rumors.size()]

# Закрываем окно
func _on_close_pressed():
	visible = false


func _on_village_button_pressed() -> void:
	pass # Replace with function body.


func _on_close_button_pressed() -> void:
	pass # Replace with function body.
