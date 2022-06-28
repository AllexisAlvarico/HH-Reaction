extends Area2D

onready var touchController = get_tree().root.get_node("Root")
onready var collider = get_node("CollisionShape2D")

var timeElapsed := 0.0

func getRadius() -> float:
	return collider.shape.radius

func randomModulate(rng: RandomNumberGenerator):
	modulate = Color(rng.randf(), rng.randf(), rng.randf())

func _process(delta: float) -> void:
	timeElapsed += delta

func _on_Shape_input_event(_viewport:Node, _event:InputEvent, _shape_idx:int) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		touchController.setReactionTime(timeElapsed)
		get_tree().queue_delete(self)
