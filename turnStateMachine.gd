extends Node3D
var p1
var p2
var p1Cam
var p2Cam
var menu
var whosTurn
var transition
@onready var gameOverScene = preload("res://gameOverScreen.tscn")
var gameOver
# If this ^ is 0, it is no one's turn
# if it is 1, it is player 1's turn
# if it is 2, it is player 2's turn 
@onready var animation_player = $AnimationPlayer
@onready var light = $DirectionalLight3D  # Change to $OmniLight3D if you are using OmniLight
@onready var timer = $Timer
@onready var player1 = $PlayerOne
@onready var player2 = $PlayerTwo

var turnCounter

# Called when the node enters the scene tree for the first time.
func _ready():
	player1.visible = false
	player2.visible = false
	
	# Start the light flash animation
	if not animation_player:
		print("Light node not found")
	animation_player.play("flash")
	# Start the timer to handle visibility after the flash
	timer.start(3.0)  # Adjust the time to match your flash duration
	timer.timeout.connect(_on_Timer_timeout)
	# get both players
	transition = $CanvasLayer/TransitionMenu
	transition.hide()
	#gameOverScene.hide()
	p1 = $PlayerOne
	p2 = $PlayerTwo
	p1Cam = p1.get_node("Neck").get_node("Camera3D")
	p2Cam = p2.get_node("Neck").get_node("Camera3D")
	# make it player one's turn
	#
	p1Cam.make_current()
	p1.myTurn = true
	whosTurn = 1
	turnCounter = 0
	gameOver = false

func _on_Timer_timeout():
	# Make players visible after the timer ends
	player1.visible = true
	player2.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gameOver == false:
		if p1.isDead == true:
			print("player 1 dead")
			var game_over_instance = gameOverScene.instantiate()
			game_over_instance.set_winner("Player 2 ")
			get_tree().root.add_child(game_over_instance)
			#gameOverScene.show()
			gameOver = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif p2.isDead == true:
			print("player 2 dead")
			var game_over_instance = gameOverScene.instantiate()
			game_over_instance.set_winner("Player 1 ")
			get_tree().root.add_child(game_over_instance)
			gameOver = true
			#gameOverScene.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func turnPass():
	if p1.isDead == false || p2.isDead == false:
		turnCounter+= 1;
		# pull up the menu
		# toggle the turn
		if gameOver == false:
			transition.show()
		# change the camera 
		if (whosTurn == 1):
			p2Cam.make_current()
			p1.myTurn = false
			p2.myTurn = true
			whosTurn = 2
		else:
			p1Cam.make_current()
			p2.myTurn = false
			p1.myTurn = true
			whosTurn = 1
		turnCounter+=1

func finishMenu():
	if gameOver == false:
		if ( whosTurn == 1):
			p1.myTurn = true
		else:
			p2.myTurn = true
		transition.hide()
