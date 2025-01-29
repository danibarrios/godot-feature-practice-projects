class_name State extends Node

@export
var animation_name: String
@export
var state_name: String
@export
var move_speed: float = 250

#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D
var animations: AnimatedSprite2D

func enter() -> void:
	animations.play(animation_name)
	parent.collisions_dictionary.get("main_collision").disabled = false

func exit() -> void:
	parent.collisions_dictionary.get("main_collision").disabled = true

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
	
func get_x_movement_orientation() -> float:
	return -1.0 if parent.velocity.x < 0 else 1.0

func get_state_name() -> String:
	push_error("functions need to be override by implementor")
	return ""
