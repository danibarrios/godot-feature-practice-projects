class_name LimboStateMachine
extends LimboHSM

@export var character : CharacterBody2D

@export var states : Array[LimboState]

func _ready() -> void:
	initialize(character)
	set_active(true)
	_binding_setup()

func _binding_setup():
	#ANY STATE transitions
	add_transition(ANYSTATE, states[StateReferences.FALL_STATE], StateReferences.FALLING)
	
	
	#IDLE STATE possible transitions
	add_transition(states[StateReferences.IDLE_STATE], states[StateReferences.RUN_STATE], StateReferences.RUNNING)
	add_transition(states[StateReferences.IDLE_STATE], states[StateReferences.JUMP_STATE], StateReferences.JUMPING)
	add_transition(states[StateReferences.IDLE_STATE], states[StateReferences.ATTACK_STATE], StateReferences.ATTACKING)
	
	#RUN STATE possible transitions
	add_transition(states[StateReferences.RUN_STATE], states[StateReferences.IDLE_STATE], StateReferences.STOPPED)
	add_transition(states[StateReferences.RUN_STATE], states[StateReferences.JUMP_STATE], StateReferences.JUMPING)
	add_transition(states[StateReferences.RUN_STATE], states[StateReferences.DASH_STATE], StateReferences.DASHING)
	add_transition(states[StateReferences.RUN_STATE], states[StateReferences.ATTACK_STATE], StateReferences.ATTACKING)
	
	#JUMP STATE possible transitions
	add_transition(states[StateReferences.JUMP_STATE], states[StateReferences.IDLE_STATE], StateReferences.LANDING)
	add_transition(states[StateReferences.JUMP_STATE], states[StateReferences.DASH_STATE], StateReferences.DASHING)
	
	#FALL STATE possible transitions
	add_transition(states[StateReferences.FALL_STATE], states[StateReferences.IDLE_STATE], StateReferences.LANDING)
	add_transition(states[StateReferences.FALL_STATE], states[StateReferences.JUMP_STATE], StateReferences.JUMPING)
	add_transition(states[StateReferences.FALL_STATE], states[StateReferences.DASH_STATE], StateReferences.DASHING)
	
	#DASH STATE possible transitions
	add_transition(states[StateReferences.DASH_STATE], states[StateReferences.IDLE_STATE], StateReferences.LANDING)
	
	#ATTACK_STATE possible transitions
	add_transition(states[StateReferences.ATTACK_STATE], states[StateReferences.IDLE_STATE], StateReferences.STOPPED)
	add_transition(states[StateReferences.ATTACK_STATE], states[StateReferences.ATTACK_STATE], StateReferences.ATTACKING)
