class_name CharacterState
extends LimboState

@export var animation_name: StringName

var blue_player: CharacterBody2D
var player_stats: PlayerStats
var states_ref: StateReferences

func _enter() -> void:
	blue_player = agent as CharacterBody2D
	blue_player.animations.play(animation_name)
	player_stats = blue_player.stats
	#prints("entering " + self.name + " state")
	
func move(x_speed: float = 300.0) -> Vector2:
	
	var dir: float = blackboard.get_var(BBNames.direction_var)
	
	if not is_zero_approx(dir):
		blue_player.velocity.x = get_direction() * x_speed
	else:
		blue_player.velocity.x = move_toward(blue_player.velocity.x, 0, x_speed)

	return blue_player.velocity
	

func has_player_jumped() -> bool:
	return blackboard.get_var(BBNames.jump_var)
	
func has_player_dashed() -> bool:
	return blackboard.get_var(BBNames.dash_var)
	
func has_player_attacked() -> bool:
	return blackboard.get_var(BBNames.attack_var)

func get_direction() -> int:
	var vel_x = blackboard.get_var(BBNames.direction_var)
	return -1 if abs(vel_x) != vel_x else 1

func process_physics(delta: float) -> void:
	blue_player.velocity.y += blue_player.gravity * delta
	blue_player.move_and_slide()
