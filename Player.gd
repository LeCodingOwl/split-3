extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

@export var bullet_speed = 25
@onready var bullet_scene = preload("res://models/bullet.tscn")
@onready var bullet_spawn_point = $Neck/Camera3D/BulletSpawn
var myTurn
var turnManager
var shot
var isDead

#var direction = Vector3.ZERO

func _ready():
	shot = true;
	position.x = randi() % 18
	position.z = randi() % 18
	myTurn = false
	isDead = false
	print("position X: " + str(position.x))
	print("position Z: " + str(position.z))

func _unhandled_input(event: InputEvent) -> void:
	#Check for mouse input to lock camera to mouse
	
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Press the esc key to stop using camera
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#Gets the mouses rotation to set the axis for the camera
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))
	if (myTurn):
		#Gets input map "shoot" and calls the the function to spawn a bullet
		if Input.is_action_just_pressed("Shoot"):
			#print("Fire")
			#spawn the bullet
			myTurn = false
			spawn_bullet()

func spawn_bullet():
	var projectile = bullet_scene.instantiate()
	add_sibling(projectile)

	# Set the position and direction of the bullet based on the spawn point
	projectile.transform = bullet_spawn_point.global_transform

	# Set the bullet's velocity to go forward in the direction the camera is facing
	var direction = bullet_spawn_point.global_transform.basis.z * -1  # Forward direction
	projectile.velocity = direction * bullet_speed


#Adds gravity to player. We may not need this
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


func _on_area_3d_area_entered(area):
	if (area.name == "bullet_area"):
		print("Player hit!")
		isDead = true
