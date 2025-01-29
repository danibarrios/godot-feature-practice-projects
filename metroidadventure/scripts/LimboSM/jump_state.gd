extends CharacterState #JumpState

func _enter():
	super()
	blue_player.velocity.y = PlayerStats.JUMP_POWER
	blackboard.set_var(BBNames.jumps_counter, blackboard.get_var(BBNames.jumps_counter) + 1)

func _exit():
	blackboard.set_var(BBNames.jump_var, false)

func _update(_delta):
	
	if not has_player_jumped() or _is_player_falling():
		dispatch(StateReferences.FALLING)
		
	if blue_player.is_on_floor():
		dispatch(StateReferences.LANDING)
	
	if has_player_dashed():
		dispatch(StateReferences.DASHING)
	
	
	#Move func allows me to move horizontally even while jumping
	#Move func also has the move_and_slide() call.
	move()
	
func _is_player_falling() -> bool:
	return blue_player.velocity.y >= 0
