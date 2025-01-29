class_name BluePlayerController
extends CharacterBody2D

@export var animations: AnimatedSprite2D
@export var stats: PlayerStats
@onready var state_machine = $LimboStateMachine
@onready var facing: Facing = $Facing
@onready var animation_player = $AnimationPlayer
@onready var snd_sword_attack = $snd_sword_attack


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	facing.face_proper_direction(velocity.x)
	if state_machine:
		state_machine.get_active_state().process_physics(delta)
	
