extends Node3D

@export
var devil1_prefab : PackedScene

@export
var root_node : Node3D

@export
var spawn_rate : float

var spawn_timer : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = spawn_rate
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_timer < spawn_rate:
		spawn_timer += delta
		
	if spawn_timer >= spawn_rate:
		spawn_timer = 0
		#var devil1 = devil1_prefab.instantiate()
		var rand_angle = randf_range(0, PI*1)
		#devil1.position = global_position + (Vector3.RIGHT * sin(rand_angle) + Vector3.FORWARD * cos(rand_angle)) * 3
		#root_node.add_child(devil1)
