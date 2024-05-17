extends Node3D

var sender
var bounces := 2
const MAX_LENGTH := 100
@onready var laser = $Laser as RayCast3D
@onready var laser_visual = $Beam

func _ready():
	# Enable the raycast and set the initial target position
	laser.enabled = true
	laser.target_position = Vector3(MAX_LENGTH, 0, 0)

func _process(delta):
	process_laser()

func process_laser():
	var current_position = laser.global_transform.origin
	var direction = laser.target_position.normalized()
	var remaining_bounces = bounces

	while remaining_bounces >= 0:
		# Update the laser's target and adjust its position to begin the raycast
		laser.global_transform.origin = current_position + direction * 0.05  # small offset to avoid immediate re-collision
		laser.target_position = direction * MAX_LENGTH
		laser.force_raycast_update()  # Force the raycast to update immediately

		if laser.is_colliding():
			var collision_point = laser.get_collision_point()
			var collision_normal = laser.get_collision_normal()
			draw_laser_beam(current_position, collision_point)
			# Offset slightly from the collision surface to prevent re-collision
			current_position = collision_point + collision_normal * 0.05
			direction = direction.bounce(collision_normal)
			remaining_bounces -= 1
		else:
			draw_laser_beam(current_position, current_position + direction * MAX_LENGTH)
			break

func draw_laser_beam(from, to):
	var distance = from.distance_to(to)
	laser_visual.global_transform.origin = from
	laser_visual.look_at(to, Vector3(0, 1, 0))  # The up direction is typically Vector3(0, 1, 0) in most 3D environments
	laser_visual.scale = Vector3(laser_visual.scale.x, laser_visual.scale.y, distance)  # Adjust the beam length