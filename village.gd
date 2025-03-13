extends Node2D

# Переменные ресурсов
var population = 9  # Начальное население (3 семьи * 3 человека)
var max_population = 52  # Лимит населения
var food = 0  # Начальная еда
var wood = 0  # Начальное дерево
var gold = 0  # Золото
var loyalty = 100  # Лояльность (не используется пока)
var tax_rate = 1  # Доход в казну

# Таймеры для прироста ресурсов
var food_timer = 0
var wood_timer = 0
var tax_timer = 0
var population_timer = 0

func _process(delta):
	food_timer += delta
	wood_timer += delta
	tax_timer += delta
	population_timer += delta

	# Каждую минуту (+1 еда, +1 дерево, +1 золото)
	if food_timer >= 60:
		food += 1
		food_timer = 0
		update_ui()

	if wood_timer >= 60:
		wood += 1
		wood_timer = 0
		update_ui()

	if tax_timer >= 60:
		gold += tax_rate
		tax_timer = 0
		update_ui()

	# Прирост населения (каждые 15 минут +1 человек)
	if population_timer >= 900 and population < max_population:
		population += 1
		population_timer = 0
		update_ui()

# Обновляем UI при изменении ресурсов
func update_ui():
	if has_node("VillageMenu"):
		get_node("VillageMenu").update_info()
