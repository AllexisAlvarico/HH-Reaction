extends Node2D

onready var area = get_node("Area2D")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_Area2D_input_event(_viewport:Node, _event:InputEvent, _shape_idx:int) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("object clicked")
		get_tree().queue_delete(area)
