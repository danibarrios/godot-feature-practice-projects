class_name StateMachine extends Node

@export
var starting_state: State

var current_state: State

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: CharacterBody2D) -> void:
	for child in get_children():
		child.parent = parent
		child.animations = parent.animations

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	handle_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	handle_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	handle_state(new_state)
		
func get_state() -> String:
	if current_state:
		return current_state.get_state_name()
	else:
		return "NO state"

func handle_state(state: State) -> void:
	if state && current_state != state:
		change_state(state)
