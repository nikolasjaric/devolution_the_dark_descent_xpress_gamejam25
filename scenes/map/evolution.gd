extends Node2D

func _on_timer_timeout() -> void:
	$EvolutionProgressBar.value += 1;

@onready var bar = $EvolutionProgressBar
@onready var icon = $Cursor

func _process(delta):
	var screen_half_offset = get_viewport_rect().size / 2.0
	bar.global_position = Vector2(screen_half_offset.x - bar.get_size().x, 10)
	$Heads.global_position = Vector2(screen_half_offset.x - bar.get_size().x, 0)
	var t = bar.value / bar.max_value  # normalized 0.0 to 1.0
	var bar_texture_width = bar.get_size().x
	if bar.value < 15 or bar.value > bar.max_value - 15:
		icon.modulate.a = 0
	else:
		icon.modulate.a = 1

	# Compute icon position relative to the progress
	var icon_x = bar.global_position.x + t*2 * bar_texture_width - 200
	var icon_y = bar.global_position.y + (bar.get_size().y / 2) - (icon.get_size().y / 2) - 7

	icon.global_position = Vector2(icon_x, icon_y)
	
