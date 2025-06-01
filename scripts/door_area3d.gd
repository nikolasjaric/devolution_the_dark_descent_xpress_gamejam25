extends Area3D

@export var teleport_target: Node3D  # Drag the target node in Inspector

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player") and teleport_target:
		if teleport_target:
			body.global_position = teleport_target.global_position
