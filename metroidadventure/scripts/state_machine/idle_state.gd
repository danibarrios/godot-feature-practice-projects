extends State #IdleState

#const state_name: String = "IdleState"

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State

func enter() -> void:
	super()
	parent.set_dash(false)
	parent.reset_jumps()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed(PlayerActions.JUMP) and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed(PlayerActions.MOVE_LEFT) or Input.is_action_just_pressed(PlayerActions.MOVE_RIGHT):
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += parent.gravity * delta
	
	parent.velocity.x = move_toward(parent.velocity.x, 0, 50)
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null

func get_state_name() -> String:
	return state_name
