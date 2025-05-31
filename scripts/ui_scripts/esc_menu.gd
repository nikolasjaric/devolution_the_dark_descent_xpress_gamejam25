extends Control



func _ready() -> void:
	visible = false  # Hide pause menu initially

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):  # Escape by default
		visible = not visible
		get_tree().paused = visible
		# Optional: also pause/unpause input for gameplay



func _on_resume_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map/citymap.tscn")
	pass # Replace with function body.


func _on_quit_to_main_menu_pressed() -> void:
	pass # Replace with function body.


func _on_exit_game_pressed():
	get_tree().quit()
	pass # Replace with function body.
