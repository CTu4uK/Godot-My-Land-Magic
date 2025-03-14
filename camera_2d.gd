extends Camera2D

# Переменные управления
var dragging = false
var last_mouse_pos = Vector2()

# Настройки масштаба
var zoom_step = 0.1  # Шаг приближения/отдаления
var min_zoom = 0.15  # Максимальное отдаление (дальше)
var max_zoom = 0.9   # Максимальное приближение (ближе)
var start_zoom = 0.5 # Начальный уровень зума

func _ready():
	make_current()  # Делаем камеру текущей
	zoom = Vector2(start_zoom, start_zoom)  # Устанавливаем начальное приближение

func _input(event):
	# Проверка нажатий мыши
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_pos = event.position

		# Исправленное приближение (колесико вверх)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			var new_zoom = zoom + Vector2(zoom_step, zoom_step)  # Отдаление
			zoom = new_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

		# Исправленное отдаление (колесико вниз)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			var new_zoom = zoom - Vector2(zoom_step, zoom_step)  # Приближение
			zoom = new_zoom.clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

	# Движение камеры при зажатой ЛКМ
	if event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		position -= delta / zoom  # Движение учитывает масштаб
		last_mouse_pos = event.position
