extends CharacterState #FallState

func _enter():
	super()
	#Set Y velocity to 0, so we can star falling due to gravity
	blue_player.velocity.y = 0
	blackboard.set_var(BBNames.jump_var, false)
	
func _update(_delta):
	
	if blue_player.is_on_floor():
		dispatch(StateReferences.LANDING)
		
	if has_player_jumped() && not _has_reached_max_jumps():
		dispatch(StateReferences.JUMPING)
	
	if has_player_dashed():
		dispatch(StateReferences.DASHING)
	
	move()
	
	
func _has_reached_max_jumps() -> bool:
	return blackboard.get_var(BBNames.jumps_counter) > PlayerStats.MAX_JUMPS
