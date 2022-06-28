extends Node2D

# refs
onready var reactionLabel = get_node("HUD/Label")
onready var spawnTimer = get_node("SpawnTimer")
onready var shapeScene = preload("res://Shape/Shape.tscn")

var screenSize := OS.get_window_safe_area()
var rng := RandomNumberGenerator.new()

var reactionTime := 0.0
var score := 0.0

var spawnDelay: float

export var spawnDelayMin := 0.5
export var spawnDelayMax := 5.0

var waitingForShape := false

func _ready() -> void:
	reactionLabel.text = "Reaction Time: " + str(reactionTime)

func setReactionTime(newReactionTime: float) -> void:
	reactionTime = newReactionTime
	score += 1.0
	reactionLabel.text = "Reaction Time: " + str(reactionTime)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _process(_delta: float) -> void:
	if !waitingForShape:
		instanceShape()
	
func instanceShape():
	rng.randomize()
	spawnDelay = rng.randf_range(spawnDelayMin, spawnDelayMax)
	spawnTimer.wait_time = spawnDelay
	spawnTimer.start()
	waitingForShape = true

func _on_SpawnTimer_timeout() -> void:
	var newShape = shapeScene.instance()
	add_child(newShape)
	newShape.position = Vector2(rng.randf_range(0 + newShape.getRadius() * 2.0, screenSize.size.x - newShape.getRadius() * 2.0),
	rng.randf_range(0 + newShape.getRadius() * 2.0, screenSize.size.y - newShape.getRadius() * 2.0))
	newShape.randomModulate(rng)
	waitingForShape = false
