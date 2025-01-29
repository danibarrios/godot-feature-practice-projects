class_name Player
extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var state_machine = $StateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	print("state: " + str(state_machine) + "unhandled_input: " + str(event))
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	#print("_physics_process: " + str(delta))
	state_machine.process_physics(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("_process: " + str(delta))
	state_machine.process_frame(delta)

	
	
