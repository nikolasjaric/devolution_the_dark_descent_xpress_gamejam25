extends MeshInstance3D

@export var teleport_target: Node3D  # Drag a target position node here


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":  # Or use `body.is_in_group("player")` for better flexibility
		if teleport_target:
			body.global_position = teleport_target.global_position
