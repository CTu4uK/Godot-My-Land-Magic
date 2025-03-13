extends Sprite2D

@onready var animation_player = $move1  # Подключаем анимацию
@onready var start_timer = $Timer  # Подключаем таймер

func _ready():
	start_timer.timeout.connect(_on_timer_timeout)  # Запускаем таймер

func _on_timer_timeout():
	print("Человечек начинает движение!")  # Для проверки в консоли
	animation_player.play("move")  # Запускаем анимацию
