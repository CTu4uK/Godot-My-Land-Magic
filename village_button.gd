extends Button

@onready var village_menu = $"../VillageMenu"

func _ready():
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	if village_menu:
		village_menu.visible = !village_menu.visible
