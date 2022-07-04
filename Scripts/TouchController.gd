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

# export var spawnDelayMin := 0.5
# export var spawnDelayMax := 5.0

# var isWaitingForShape := false
var isGameOver := true
export var shapesAmount := 0

# var isFingerCircling := false

func _ready() -> void:
	grid.add_constant_override("hseparation", 20)
	grid.add_constant_override("vseparation", 20)
	reactionLabel.text = "Reaction Time: " + str(reactionTime)
	scoreLabel.text = "Score: " + str(score)
	timeLeftLabel.text = "Time Left: " + str(endTimer.time_left as int)
	setupShapeGrid()

func setReactionTime(newReactionTime: float) -> void:
	reactionTime = newReactionTime
	score += 1.0
	reactionLabel.text = "Reaction Time: " + str(reactionTime)
	scoreLabel.text = "Score: " + str(score)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _process(_delta: float) -> void:
	if !isGameOver:
		timeLeftLabel.text = "Time Left: " + str(endTimer.time_left as int)
		# if !isWaitingForShape:
		# 	instanceShape()

func setupShapeGrid():
	for i in shapesAmount:
		var newShape = shapeScene.instance()
		grid.add_child(newShape)
		newShape.modulate.a = 0.0
		print("shape " + str(i) + " added")
		yield(get_tree().create_timer(0.05), "timeout")
	isGameOver = false
	endTimer.start()
	
# func instanceShape():
# 	rng.randomize()
# 	spawnDelay = rng.randf_range(spawnDelayMin, spawnDelayMax)
# 	spawnTimer.wait_time = spawnDelay
# 	spawnTimer.start()
# 	isWaitingForShape = true

# func _on_SpawnTimer_timeout() -> void:
# 	pass
	# if !isGameOver:
	# 	var newShape = shapeScene.instance()
	# 	add_child(newShape)
	# 	newShape.position = Vector2(rng.randf_range(0 + newShape.getRadius() * 2.0, screenSize.size.x - newShape.getRadius() * 2.0),
	# 	rng.randf_range(0 + newShape.getRadius() * 2.0, screenSize.size.y - newShape.getRadius() * 2.0))
	# 	newShape.randomModulate(rng)
	# 	isWaitingForShape = false

func _on_EndTimer_timeout() -> void:
	isGameOver = true
