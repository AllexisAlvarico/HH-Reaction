extends Node2D

# refs
onready var multiplierLabel = get_node("HUD/Theme/MultiplierLabel")
onready var scoreLabel = get_node("HUD/Theme/ScoreLabel")
onready var timeLeftLabel = get_node("HUD/Theme/TimeLeftLabel")
onready var endTimer = get_node("EndTimer")
onready var grid = get_node("CanvasLayer/GridContainer")
onready var quitConfirm = get_node("HUD/Theme/WindowDialog")
onready var shapeScene = preload("res://Shape/Shape.tscn")

var screenSize := OS.get_window_safe_area()
var rng := RandomNumberGenerator.new()

var score := 0.0

var isGameOver := true
export var shapesAmount := 0


func _ready() -> void:
	scoreLabel.text = "Score: " + str(score)
	# timeLeftLabel.text = "Time Left: " + str(endTimer.time_left as int)
	setupShapeGrid()

func setScore(newScore: float) -> void:
	score += newScore
	score = round(score)
	scoreLabel.text = "Score: " + str(score) + "pts"

func setMultiplier(newMultiplier: float):
	multiplierLabel.text = "Multiplier: x" + str(newMultiplier)

func _process(_delta: float) -> void:
	if !isGameOver:
		timeLeftLabel.text = "Time Left: " + str(endTimer.time_left as int)

func setupShapeGrid():
	for i in shapesAmount:
		var newShape = shapeScene.instance()
		grid.add_child(newShape)
		newShape.modulate.a = 0.0
		yield(get_tree().create_timer(0.01), "timeout")
	isGameOver = false
	endTimer.start()

func _on_EndTimer_timeout() -> void:
	isGameOver = true


func _on_QuitButton_button_up() -> void:
	quitConfirm.show()
	get_tree().paused = true

func _on_ConfirmButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MenuScene.tscn")


func _on_CancelButton_button_up() -> void:
	quitConfirm.hide()
	get_tree().paused = false
