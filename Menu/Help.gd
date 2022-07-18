extends Control

func _on_Button_button_up() -> void:
    get_tree().root.get_node("Root").queue_free()
    get_tree().change_scene("res://Scenes/MenuScene.tscn")