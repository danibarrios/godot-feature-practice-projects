extends JumpState #DoubleJump
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed(PlayerActions.DASH) && !parent.get_dash():
		return dash_state
	return null

func get_state_name() -> String:
	return state_name
