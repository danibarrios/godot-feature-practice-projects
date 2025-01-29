extends State #FallState

#const state_name: String = "FallState"

@export var idle_state: State
@export var jump_state: State
@export var double_jump_state: State
@export var move_state: State
@export var dash_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed(PlayerActions.JUMP):
		#print("parent: " + str(parent) + " is on the floor? " + str(parent.is_on_floor()))
		if parent.can_jump():
			return double_jump_state
	if Input.is_action_just_pressed(PlayerActions.DASH) && !parent.get_dash():
		return dash_state
	return null


func process_physics(delta: float) -> State:
	parent.velocity.y += parent.gravity * delta

	var movement = Input.get_axis(PlayerActions.MOVE_LEFT, PlayerActions.MOVE_RIGHT) * move_speed
	
	if movement != 0:
		parent.animations.flip_h = movement < 0
		parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null

func get_state_name() -> String:
	return state_name
