extends Node2D

# refs
onready var reactionLabel = get_node("HUD/Theme/ReactionLabel")
onready var scoreLabel = get_node("HUD/Theme/ScoreLabel")
onready var timeLeftLabel = get_node("HUD/Theme/TimeLeftLabel")
onready var endTimer = get_node("EndTimer")
onready var grid = get_node("CanvasLayer/GridContainer")
onready var shapeScene = preload("res://Shape/Shape.tscn")

var screenSize := OS.get_window_safe_area()
var rng := RandomNumberGenerator.new()

var reactionTime := 0.0
var score := 0.0

var spawnDelay: float

var isGameOver := true
export var shapesAmount := 0


func _ready() -> void:
	scoreLabel.text = "Score: " + str(score)
	timeLeftLabel.text = "Time Left: " + str(endTimer.time_left as int)
	setupShapeGrid()

func setScore(newScore: float) -> void:
	score += newScore
	score = round(score)
	scoreLabel.text = "Score: " + str(score)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

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
