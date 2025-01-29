extends CharacterState #RunState

func _enter():
	super()
	#Reset jump counter to Zero
	blackboard.set_var(BBNames.jumps_counter, 0)

func _update(_delta):
	
	if not blue_player.is_on_floor():
		dispatch(StateReferences.FALLING)
	
	if has_player_jumped():
		dispatch(StateReferences.JUMPING)
		
	if has_player_dashed():
		dispatch(StateReferences.DASHING)
	
	if has_player_attacked():
		dispatch(StateReferences.ATTACKING)
		
	var direction: Vector2 = move()
	
	if Vector2.ZERO.is_equal_approx(direction):
		dispatch(StateReferences.STOPPED, direction)
