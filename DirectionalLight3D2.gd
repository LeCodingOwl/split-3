extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var light = $DirectionalLight3D  # Change to $OmniLight3D if you are using OmniLight
@onready var timer = $Timer
@onready var player1 = $Player1
@onready var player2 = $Player2

func _ready():
	# Check if player nodes are set correctly
	if not player1:
		print("Player1 node not found")
	if not player2:
		print("Player2 node not found")
	
	# Proceed only if both player nodes are found
	if player1 and player2:
		# Initially make players invisible
		player1.visible = false
		player2.visible = false
		
		# Start the light flash animation
		animation_player.play("flash")

		# Start the timer to handle visibility after the flash
		timer.start(1.0)  # Adjust the time to match your flash duration
		timer.timeout.connect(_on_Timer_timeout)
	else:
		print("Players not properly initialized, aborting visibility change")

func _on_Timer_timeout():
	# Make players visible after the timer ends
	if player1:
		player1.visible = true
	if player2:
		player2.visible = true
