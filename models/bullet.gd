extends RigidBody3D

var velocity = Vector3()
var bounce_factor = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector3(10, 10, 10)
	
func _integrate_forces(state: PhysicsDirectBodyState3D):
	#apply the velocity to the ball
	state.linear_velocity = velocity
	
	for collision in state.get_contact_count():
		var collision_normal = state.get_contact_normal(collision)
		velocity = velocity.bounce(collision_normal) * bounce_factor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	#Clears the bullet from the branch
	queue_free()
