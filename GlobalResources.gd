extends Node

# **Глобальные ресурсы для всех поселений**
var food: int = 0
var wood: int = 0
var gold: int = 0
var stone: int = 0

# **Население и лояльность**
var population: int = 0
var loyalty: int = 100

# **✅ Добавляем сигнал обновления населения**
signal population_updated(total_population)

# **✅ Функция для обновления населения**
func update_population():
	var total_population = population  # Начинаем с базового населения королевства
	
	# Получаем население деревни, если оно есть
	if has_node("/root/Village/VillageMenu"):
		total_population += get_node("/root/Village/VillageMenu").get_population()
	
	# Получаем население шахты, если она есть
	if has_node("/root/StoneMine/Mine"):
		total_population += get_node("/root/StoneMine/Mine").get_population()
	
	print("[DEBUG] Обновленное общее население:", total_population)
	
	# **Обновляем глобальную переменную**
	population = total_population
	
	# **Вызываем сигнал для обновления замка**
	emit_signal("population_updated", population)
