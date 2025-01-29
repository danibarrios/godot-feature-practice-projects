extends State #JumpState
class_name JumpState
#const state_name: String = "JumpState"

@export var fall_state: State
@export var idle_state: State
@export var move_state: State
@export var dash_state: State
@export var double_jump_state: State
@export var jump_force: float = 450.0

func enter() -> void:
	super()
	#print("Jump State Enter")
	parent.velocity.y =-jump_force
	parent.set_dash(false)
	parent.jump_count()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed(PlayerActions.DASH):
		return dash_state
	return null

func process_physics(delta: float) -> State:
	if Input.is_action_just_released(PlayerActions.JUMP):
		parent.velocity.y = 0
	else:
		#Applies gravity to vertical movement
		parent.velocity.y += parent.gravity * delta
	
	#Calculate lateral movement in the air
	var movement = Input.get_axis(PlayerActions.MOVE_LEFT, PlayerActions.MOVE_RIGHT) * move_speed
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	
	#Process physics
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return fall_state
		
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null

func get_state_name() -> String:
	return state_name
