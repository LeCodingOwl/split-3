extends Node3D
# var p1 = 
# var p2 = 
# var menu = 
var currentTurn = 0; 
# If this ^ is 0, it is no one's turn
# if it is 1, it is player 1's turn
# if it is 2, it is player 2's turn 

var turnCounter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func turnPass():
	turnCounter+= 1;
	var prevTurn = currentTurn;
	currentTurn = 0;
	await swapMenu();
	if (prevTurn == 0 || prevTurn == 2):
		currentTurn = 1
	else:
		currentTurn = 2;
	
	# It has now swapped to the next person's turn
		
	
func swapMenu():
	await fadeMenu();
	# this should display a menu 
	# return when a click has happened
	await fadeOutMenu();
	pass
	
func fadeMenu():
	# This draws the menu 
	# return when the fade is done
	pass
	
	
func fadeOutMenu();

	pass
