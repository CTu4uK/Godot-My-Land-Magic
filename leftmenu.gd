extends Control

# Переменные ресурсов
var population = 1000
var loyalty = 75
var gold = 500
var stone = 300
var wood = 200
var food = 800
var rumors = [
	"Купцы жалуются на разбойников на дорогах...",
	"Старый мельник пропал без вести...",
	"Горожане говорят, что леса стали опасны..."
]

# Получаем ссылки на UI-элементы
@onready var population_label = $PopulationLabel
@onready var loyalty_label = $LoyaltyLabel
@onready var gold_label = $GoldLabel
@onready var stone_label = $StoneLabel
@onready var wood_label = $WoodLabel
@onready var food_label = $FoodLabel
@onready var rumors_label = $RumorsLabel

func _ready():
	update_ui()

# Функция обновления интерфейса
func update_ui():
	population_label.text = "Население: " + str(population)
	loyalty_label.text = "Лояльность: " + str(loyalty) + "%"
	gold_label.text = "Золото: " + str(gold)
	stone_label.text = "Камень: " + str(stone)
	wood_label.text = "Дерево: " + str(wood)
	food_label.text = "Пища: " + str(food)
	rumors_label.text = "Слухи: " + rumors.pick_random()
