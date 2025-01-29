extends CharacterState

var timer: float = 0.0
const dash_time_anim: float = 0.3

# Called when the node enters the scene tree for the first time.
func _enter():
	super()
	dash()
	timer = dash_time_anim

func _exit():
	blackboard.set_var(BBNames.dash_var, false)
	blue_player.velocity.x = player_stats.RUN_SPEED

func _update(delta):
	timer -= delta

	if timer <= 0:
		if blue_player.is_on_floor():
			dispatch(StateReferences.LANDING)
		else:
			dispatch(StateReferences.FALLING)
	else:
		dash()

func process_physics(_delta: float) -> void:
	blue_player.move_and_slide()

func dash() -> void:
	blue_player.velocity.x = PlayerStats.DASH_SPEED * get_direction()
	blue_player.velocity.y = 0

func _printThings():
	prints("-----------------")
	prints("gravity " + str(blue_player.gravity))
	prints("velocity.y " + str(blue_player.velocity.y))
	prints("velocity.x " + str(blue_player.velocity.x))
	prints("timer: " + str(timer))
	prints(blackboard.get_var(BBNames.direction_var))
