extends RigidBody3D

var velocity = Vector3()
var bounce_factor = 1.0

# Called when the node enters the scene tree for the first time.
var turnManager

func _ready():
	turnManager = $".."

func _integrate_forces(state: PhysicsDirectBodyState3D):
	# Apply the velocity to the bullet
	state.linear_velocity = velocity
	
	for collision in state.get_contact_count():
		var collision_normal = state.get_contact_normal(collision)
		velocity = velocity.bounce(collision_normal) * bounce_factor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	# Clears the bullet from the branch
	removeBullet()
	
func removeBullet():
	turnManager.turnPass()
	queue_free()
