extends Node3D
var p1
var p2
var p1Cam
var p2Cam
var menu
var whosTurn
var transition
# If this ^ is 0, it is no one's turn
# if it is 1, it is player 1's turn
# if it is 2, it is player 2's turn 

var turnCounter

# Called when the node enters the scene tree for the first time.
func _ready():
	# get both players
	transition = $CanvasLayer/TransitionMenu
	transition.hide()
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if p1.isDead == true:
		print("player 1 dead")
	elif p2.isDead == true:
		print("player 2 dead")
	pass


func turnPass():
	if p1.isDead == false || p2.isDead == false:
		turnCounter+= 1;
		# pull up the menu
		# toggle the turn
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
	if ( whosTurn == 1):
		p1.myTurn = true
	else:
		p2.myTurn = true
	transition.hide()
