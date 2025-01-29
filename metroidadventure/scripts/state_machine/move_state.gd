extends State #MoveState

#const state_name: String = "MoveState"

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var slide_state: State

func enter() -> void:
	super()
	parent.reset_jumps()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed(PlayerActions.JUMP):
		return jump_state
	if Input.is_action_just_pressed(PlayerActions.SLIDE):
		return slide_state
	
	return null

func process_physics(delta: float) -> State:
	var new_state: State = null
	parent.velocity.y += parent.gravity * delta
	
	var direction = Input.get_axis(PlayerActions.MOVE_LEFT, PlayerActions.MOVE_RIGHT) * move_speed
	#print("direction: " + str(direction))
	
	if direction == 0:
		parent.velocity.x = move_toward(parent.velocity.x, 0, 25)	
		new_state = idle_state
	else:
		parent.velocity.x = move_toward(parent.velocity.x, move_speed * direction, 25)
		parent.animations.flip_h = direction < 0
	
	if !parent.is_on_floor():
		new_state = fall_state
		
	parent.move_and_slide()

	return new_state

func get_state_name() -> String:
	return state_name
