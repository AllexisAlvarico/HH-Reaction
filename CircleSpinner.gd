extends Node2D

onready var circle = get_node("TextureProgress")
onready var center = get_node("TextureProgress/Center")
onready var timer = get_node("TextureProgress/Timer")
onready var touchController = get_tree().root.get_node("Root")

var isActive := false

var eventId := -1

func _process(_delta: float) -> void:
	if !isActive:
		circle.value = -180.0


func _on_TextureProgress_value_changed(_value:float) -> void:
	isActive = true
	timer.start()

func getIsActive():
	return isActive

func _on_Timer_timeout() -> void:
	isActive = false

func _on_TextureProgress_gui_input(event:InputEvent) -> void:
	print(eventId)
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = event.index
		else:
			eventId = -1
	elif event is InputEventScreenDrag:
		if eventId == event.index && !touchController.isGameOver:
			var dir = (get_global_mouse_position() - center.global_position).normalized()
			center.global_rotation = dir.angle()
			circle.value = rad2deg(center.global_rotation)
