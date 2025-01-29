extends CharacterState #IDLE State

func _enter():
	super()
	#Reset jump counter to Zero
	blackboard.set_var(BBNames.jumps_counter, 0)

func _update(_delta):
	#if player tried to dash, set it to false since it's not allowed from idle state
	if has_player_dashed():
		blackboard.set_var(BBNames.dash_var, false)
	
	if has_player_attacked():
		dispatch(StateReferences.ATTACKING)
		
	if has_player_jumped():
		dispatch(StateReferences.JUMPING)
	
	if not blue_player.is_on_floor():
		dispatch(StateReferences.FALLING)
	
	var velocity: Vector2 = move()
		
	if not Vector2.ZERO.is_equal_approx(velocity):
		dispatch(StateReferences.RUNNING, velocity)
