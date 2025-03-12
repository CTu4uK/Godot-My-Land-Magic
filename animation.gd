extends Node2D  # Или другой подходящий класс

@onready var animation_player = $move1
var move_timer: Timer

func _ready():
	# Создаем таймер
	move_timer = Timer.new()
	move_timer.wait_time = 60.0  # Одна минута
	move_timer.autostart = true
	move_timer.one_shot = false
	move_timer.timeout.connect(_on_move_timer_timeout)
	add_child(move_timer)

	# Запуск таймера
	move_timer.start()

# Функция вызывается каждую минуту
func _on_move_timer_timeout():
	if animation_player:
		animation_player.play("move")  # Название анимации
