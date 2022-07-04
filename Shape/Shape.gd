tool
extends TextureRect

onready var audioPlayer = get_node("AudioStreamPlayer")
onready var touchController = get_tree().root.get_node("Root")
onready var circleSpinner = get_tree().root.get_node("Root/CanvasLayer/CircleSpinner")
onready var explosionScene = preload("res://explosion.tscn")

var timeElapsed := 0.0
var eventId := -1

export(Color) var inactiveColor
export(Color) var activeColor

var isActive := true

onready var tween := get_node("Tween")

# export(Color, RGB) var color = Color.white setget setColor

# func setColor(value: Color):
# 	color = value
# 	modulate = color	

# func randomModulate(rng: RandomNumberGenerator):
# 	setColor(Color(rng.randf(), rng.randf(), rng.randf()))

func _ready() -> void:
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT_IN)
	tween.start()

func _process(delta: float) -> void:
	timeElapsed += delta
	if !touchController.isGameOver && isActive:
		if circleSpinner.getIsActive():
			modulate = modulate.linear_interpolate(activeColor, 0.2)
		else:
			modulate = modulate.linear_interpolate(inactiveColor, 0.2)

func _on_Shape_gui_input(event:InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = event.index
			if !touchController.isGameOver && \
				isActive:
					touchController.setReactionTime(timeElapsed)
					isActive = false
					modulate.a = 0.0
					var explosion = explosionScene.instance()
					get_tree().root.add_child(explosion)
					explosion.position = rect_global_position + rect_size / 2.0
					explosion.emitting = true
					playSound()
		else:
			eventId = -1

func playSound():
	randomize()
	audioPlayer.pitch_scale = touchController.rng.randf_range(0.8, 1.2)
	audioPlayer.playing = true
