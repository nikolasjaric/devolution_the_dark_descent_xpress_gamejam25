extends TextureProgressBar

@export var player : CharacterBody3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		player.healthChanged.connect(update_hb)
		update_hb()
	else:
		push_error("Player not assigned to health bar!")


func update_hb():
	if player.maxHealth > 0:
		value = float(player.currentHealth) * 100.0 / float(player.maxHealth)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
