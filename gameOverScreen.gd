extends Control

# Function to set the winner's name
func set_winner(winner_name: String):
	$ColorRect/WinnerLabel.text = winner_name + " wins!"
	#print("Player " + winner_name + " wins!")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_pressed():
	get_tree().reload_current_scene()
	queue_free()


func _on_exit_pressed():
	get_tree().quit()
