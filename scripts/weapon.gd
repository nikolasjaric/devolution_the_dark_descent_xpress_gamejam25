extends Node3D

@export 
var bullet_prefab : PackedScene

@export
var root_node : Node3D



@export
var shoot_position : Node3D

@export
var shoot_rate : float

@onready var shooting_audio_player = $ShotSound

var shoot_timer : float

# Called when the node enters the scene tree for the first time.
func _ready():
	#$MuzzleFlash/Timer.connect("timeout", func(): $MuzzleFlash.visible = false)
	#$MuzzleFlash/Timer.set_wait_time(0.03)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if shoot_timer < shoot_rate:
		shoot_timer += delta
	
	if Input.is_action_pressed("shoot") and shoot_timer >= shoot_rate:
		
		shooting_audio_player.play()
		
		shoot_timer = 0
		var bullet = bullet_prefab.instantiate()
		root_node.add_child(bullet)
		bullet.global_position = shoot_position.global_position
		
		#bullet.bullet_direction = -get_global_transform().basis.z
		#bullet.bullet_direction = shoot_position.global_transform.basis.z.normalized()
		bullet.bullet_direction = shoot_position.global_transform.basis.z.normalized()

		
		print("Direction: ", bullet.bullet_direction)


		
		#$MuzzleFlash.visible = true
		#$MuzzleFlash/Timer.start()
