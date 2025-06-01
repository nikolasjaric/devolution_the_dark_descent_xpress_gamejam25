extends CharacterBody3D


@export
var move_speed : float

@onready var navigation_agent := $NavigationAgent3D as NavigationAgent3D

var player : Node3D

@export
var initial_health : float

var current_health : float

@export var jump_strength : float = 16.0
@export var gravity : float = 20.0

var jump_timer := 0.0
var jump_interval := 1

var last_direction := Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = initial_health
	$Control/TextureProgressBar.max_value = initial_health
	pass # Replace with function body.



func _process(delta):
	
	if current_health <= 0:
		queue_free()
	
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	
	if player != null:
		navigation_agent.set_target_position(player.global_position)
		var dir = global_position.direction_to(navigation_agent.get_next_path_position()).normalized()

		# Only update last_direction if there's real movement
		if dir.length() > 0.1:
			last_direction = dir

		# Always use last_direction for movement, even in air
		velocity.x = last_direction.x * move_speed
		velocity.z = last_direction.z * move_speed

	# Gravity and Jump
	if is_on_floor():
		jump_timer += delta
		if jump_timer >= jump_interval:
			velocity.y = jump_strength
			jump_timer = 0.0
	else:
		velocity.y -= gravity * delta

	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Bullet"):
		current_health -= 10
		$Control/TextureProgressBar.value = current_health
