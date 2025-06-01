extends Node2D

func _ready():
	$HealthProgressBar.value = 90;

func _on_timer_timeout() -> void:
	pass
	#$HealthProgressBar.value -= 1;

@onready var bar = $HealthProgressBar
@onready var icon = $Cursor

func _process(delta):
	var screen_half_offset = get_viewport_rect().size / 2.0
	bar.global_position = Vector2(screen_half_offset.x*2 - 280, screen_half_offset.y*2 - 90)
	var t = bar.value / bar.max_value  # normalized 0.0 to 1.0
	var bar_texture_width = bar.get_size().x
	if bar.value < 15:
		icon.modulate.a = 0
	else:
		icon.modulate.a = 1

	# Compute icon position relative to the progress
	var icon_x = bar.global_position.x + t*2 * bar_texture_width - 220
	var icon_y = bar.global_position.y + (bar.get_size().y / 2) - (icon.get_size().y / 2) - 7

	icon.global_position = Vector2(icon_x, icon_y)
	


func _on_player_health_changed(health) -> void:
	$HealthProgressBar.value = lerp(10, 90, inverse_lerp(0,100,health));
