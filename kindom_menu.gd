extends Control

@onready var kindom_label = $Kindom
@onready var res_label = $Res
@onready var pop_label = $Popul
@onready var loy_label = $Loy
@onready var close_button = $CloseButton

# Отдельные ресурсы
var total_food = 0
var total_wood = 0
var total_gold = 0
var total_population = 0
var loyalty = 100  # Пока фиксированное значение

func _ready():
	visible = false  # Скрываем меню при старте
	close_button.pressed.connect(_on_close_pressed)
	update_info()

func update_info():
	# Обновляем информацию в меню
	kindom_label.text = "Графство Черни"
	res_label.text = "Еда: %d\nДерево: %d\nЗолото: %d" % [total_food, total_wood, total_gold]
	pop_label.text = "Население: %d" % total_population
	loy_label.text = "Лояльность: %d" % loyalty

func _on_close_pressed():
	visible = false

# Устанавливаем новые значения ресурсов
func set_resources(food, wood, gold):
	total_food = food
	total_wood = wood
	total_gold = gold
	update_info()

func set_population(new_population):
	total_population = new_population
	update_info()
