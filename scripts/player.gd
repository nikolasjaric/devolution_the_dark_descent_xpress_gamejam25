extends CharacterBody3D

@export
var SPEED = 5.0

signal healthChanged
@export var maxHealth := 100
var currentHealth := maxHealth


@onready
var camera : Camera3D = $CameraPivot/SpringArm3D/Camera3D

@onready
var animation = $Character/AnimationPlayer

@onready var walking_audio_player = $Footsteps 

@onready var jump_audio_player = $JumpSound

const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics(3d/default_gravity")

var is_alive : bool = true
var was_on_floor_prev_frame = true # Add this new variable. Initialize to true as player starts on ground.

func get_mouse_position_on_y0_plane():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)

	var plane = Plane(Vector3.UP, self.position.y)  # Plane at y=0
	var intersection = plane.intersects_ray(ray_origin, ray_direction)
	
	if intersection != null:
		return intersection
	else:
		return null

func _process(delta):
	var point_on_plane = get_mouse_position_on_y0_plane()
	if point_on_plane != null:
		$Character.look_at(point_on_plane);
		#$Character.rotation.x += deg_to_rad(90)
		#$Character.rotation.y += deg_to_rad(180)


func _physics_process(delta):
	
	if !is_alive:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		walking_audio_player.stop()
		
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		# Play the jump sound ONLY when the jump input is received AND on the floor
		if jump_audio_player: # Basic check to make sure the node exists (good practice)
			jump_audio_player.play(0.5)
		
		if walking_audio_player.playing:
			walking_audio_player.stop()
		# Stop walking audio immediately when jumping

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("right", "left", "back", "forward")
	var direction := (Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
	var sprinting := Input.is_action_pressed("sprint")
	
	var multiplier := 1.0
	if sprinting:
		multiplier = 1.65
	
	if direction:
		velocity.x = direction.x * SPEED * multiplier
		velocity.z = direction.z * SPEED * multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if input_dir:
		if sprinting:
			animation.play("run")
		else:
			animation.play("walk")
	else:
		animation.play("idle")

	move_and_slide()
	
	if velocity.length() > 0.1: # Check if player is moving
			if not walking_audio_player.playing: # CONDITION A
				walking_audio_player.play()
	else:
		walking_audio_player.stop()
	
	
	
	#var mouse_pos = get_viewport().get_mouse_position()
	#var ray_origin = camera.project_ray_origin(mouse_pos)
	#
	#var ray_direction = ray_origin + camera.project_ray_normal(mouse_pos) * 500
	#var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_direction)
	#
	#ray_query.collide_with_bodies = true
	#
	#var space_state = get_world_3d().direct_space_state
	#var ray_result = space_state.intersect_ray(ray_query)
	#
	#if !ray_result.is_empty():
		#if ray_result.collider != self:
			#var target_position = ray_result.position
			#target_position.y += 1.0  # Adjust this value to point 1 meter above the hit point
			#$Armature_003.look_at(target_position)
			
	
	
func take_damage(amount: int) -> void:
	currentHealth = max(currentHealth - amount, 0)
	emit_signal("healthChanged")
	if currentHealth == 0:
		die()
		
func die():
	is_alive = false
	if get_node_or_null("Weapon"):
		$Weapon.queue_free()
	if get_node_or_null("MeshInstance3D"):
		$MeshInstance3D.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body.is_in_group("Enemy"):
	#	is_alive = false
	if body.is_in_group("Enemy"):
		take_damage(20)  # Example: take 20 damage on contact
	
		
		if get_node_or_null("Weapon") != null:
			$Weapon.queue_free()
			
		if get_node_or_null("MeshInstance3D") != null:
			$MeshInstance3D.queue_free()
	pass # Replace with function body.
