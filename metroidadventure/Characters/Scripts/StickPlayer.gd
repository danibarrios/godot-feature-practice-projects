class_name StickPlayerController
extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var collisions_dictionary = {
	"main_collision": $MainCollision2D,
	"dash_collision": $DashCollisionShape2D,
	"slide_collision": $SlideCollisionShape2D
}

var player_dashed: bool = false
var player_jumps_counter = 0
var player_max_jumps = 3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	#print("state: " + str(state_machine) + "unhandled_input: " + str(event))
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	#print("_physics_process: " + str(delta))
	state_machine.process_physics(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("_process: " + str(delta))
	state_machine.process_frame(delta)

func get_dash() -> bool:
	return player_dashed

func set_dash(dashed: bool) -> void:
	player_dashed = dashed
	
func jump_count() -> void:
	player_jumps_counter += 1

func reset_jumps() -> void:
	player_jumps_counter = 0
	
func can_jump() -> bool:
	return player_jumps_counter < player_max_jumps
