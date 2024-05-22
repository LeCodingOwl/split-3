extends RigidBody3D

var velocity = Vector3()
var bounce_factor = 1.0
var turnManager
var maxBounces = 3
var currentBounces

func _ready():
	currentBounces = 0
	turnManager = $".."

func _physics_process(delta):
	# Move the bullet and check for collisions
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		# Ensure collision_info is not null and get the collision normal
		var collision_normal = collision_info.get_normal()
		# Calculate the bounced velocity
		velocity = velocity.bounce(collision_normal) * bounce_factor
		
		currentBounces+= 1
		if (currentBounces >= maxBounces):
			removeBullet()

func _process(delta):
	pass


#func _on_timer_timeout():
	# Clears the bullet from the branch
	#removeBullet()

func removeBullet():
	turnManager.turnPass()
	velocity = Vector3(0,0,0)
