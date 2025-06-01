extends Node2D

@export var slot_texture: Texture2D
@export var selected_texture: Texture2D

var slot = 0
var items = [null, null]

func get_current_item(slot: int):
	return items[slot]

func equip_item(item, slot: int):
	items[slot] = item;
	queue_redraw()

func _process(delta):
	if Input.is_action_just_pressed("1"):
		slot = 0
		queue_redraw()
	elif Input.is_action_just_pressed("2"):
		slot = 1
		queue_redraw()

func _draw():
	var screen_size = get_viewport_rect().size
	var tex_size = slot_texture.get_size() * 2
	var pos1 = Vector2(20, screen_size.y/2 - tex_size.y - 20)
	draw_texture_rect(slot_texture, Rect2(pos1, tex_size), false)
	var pos2 = Vector2(20+tex_size.y+5, screen_size.y/2 - tex_size.y - 20)
	draw_texture_rect(slot_texture, Rect2(pos2, tex_size), false)
	if items[0]:
		draw_texture_rect(items[0], Rect2(pos1, tex_size), false)
	if items[1]:
		draw_texture_rect(items[1], Rect2(pos2, tex_size), false)

	if slot == 0:
		draw_texture_rect(selected_texture, Rect2(pos1, tex_size), false)
	elif slot == 1:
		draw_texture_rect(selected_texture, Rect2(pos2, tex_size), false)
