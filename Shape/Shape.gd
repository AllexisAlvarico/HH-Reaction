tool
extends TextureRect

onready var touchController = get_tree().root.get_node("Root")
onready var circleSpinner = get_tree().root.get_node("Root/CanvasLayer/CircleSpinner")

var timeElapsed := 0.0
var eventId := -1

onready var tween := get_node("Tween")

export(Color, RGB) var color = Color.white setget setColor

func setColor(value: Color):
	color = value
	modulate = color	

func randomModulate(rng: RandomNumberGenerator):
	setColor(Color(rng.randf(), rng.randf(), rng.randf()))

func _ready() -> void:
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT_IN)
	tween.start()

func _process(delta: float) -> void:
	timeElapsed += delta

func _on_Shape_gui_input(event:InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = event.index
			if eventId > 0 && circleSpinner.getIsActive() && !touchController.isGameOver:
					touchController.setReactionTime(timeElapsed)
					get_tree().queue_delete(self)
		else:
			eventId = -1
