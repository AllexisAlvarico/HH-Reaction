extends Control

func _ready() -> void:
	$Control/PlayButton.grab_focus()

func _on_PlayButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://Scenes/TestScene.tscn")

func _on_HelpButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://Scenes/HelpScene.tscn")

func _on_BackButton_button_up() -> void:
	get_tree().quit()
