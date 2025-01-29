class_name PlayerInput 
extends Node

@export var limbo_hsm: LimboHSM


var blackboard: Blackboard
var input_direction: float
var jump: bool
var jumps_counter: int
var dash: bool
var attack: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	limbo_hsm = $"../LimboStateMachine"
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BBNames.direction_var, self, "input_direction", false)
	blackboard.bind_var_to_property(BBNames.jump_var, self, "jump", false)
	blackboard.bind_var_to_property(BBNames.jumps_counter, self, 'jumps_counter', false)
	blackboard.bind_var_to_property(BBNames.dash_var, self, 'dash', false)
	blackboard.bind_var_to_property(BBNames.attack_var, self, 'attack', false)

func _unhandled_input(_event):
	input_direction = Input.get_axis(PlayerActions.MOVE_LEFT, PlayerActions.MOVE_RIGHT)
	
	if Input.is_action_just_pressed(PlayerActions.JUMP):
		jump = is_a_valid_action(StateReferences.JUMPING)
	if Input.is_action_just_released(PlayerActions.JUMP):
		jump = false

	if Input.is_action_just_pressed(PlayerActions.DASH):
		dash = is_a_valid_action(StateReferences.DASHING)
		
	if Input.is_action_just_pressed(PlayerActions.ATTACK):
		attack = is_a_valid_action(StateReferences.ATTACKING)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#Check if the current state has the transition to a new setted.
func is_a_valid_action(transition: StringName) -> bool:
	var current_state = limbo_hsm.get_active_state()
	return limbo_hsm.has_transition(current_state, transition)
	
