tool
extends Area2D

onready var touchController = get_tree().root.get_node("Root")
onready var collider = get_node("CollisionShape2D")

var timeElapsed := 0.0
var isClickable := true

export(Color, RGB) var color = Color.white setget setColor

func setColor(value: Color):
	color = value
	modulate = color	

func getRadius() -> float:
	return collider.shape.radius

func setIsClickable(value: bool):
	isClickable = value

func randomModulate(rng: RandomNumberGenerator):
	setColor(Color(rng.randf(), rng.randf(), rng.randf()))

func _process(delta: float) -> void:
	timeElapsed += delta

func _on_Shape_input_event(_viewport:Node, _event:InputEvent, _shape_idx:int) -> void:
	if Input.is_action_just_pressed("ui_accept") && isClickable:
		touchController.setReactionTime(timeElapsed)
		get_tree().queue_delete(self)
