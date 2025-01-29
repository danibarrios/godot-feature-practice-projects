class_name StateReferences
extends Resource

#states
static var IDLE_STATE: int = 0
static var RUN_STATE: int = 1
static var JUMP_STATE: int = 2
static var FALL_STATE: int = 3
static var DASH_STATE: int = 4
static var ATTACK_STATE: int = 5
static var SLIDE_STATE: int = 6

static var IDLE_NAME: StringName = "idle_state"
static var RUN_NAME: StringName = "run_state"
static var JUMP_NAME: StringName = "jump_state"
static var FALL_NAME: StringName = "fall_state"
static var DASH_NAME: StringName = "dash_state"
static var SLIDE_NAME: StringName = "slide_state"
static var ATTACK_NAME: StringName = "attack_state"

#transitions
static var RUNNING: StringName = "running"
static var STOPPED: StringName = "stopped"
static var JUMPING: StringName = "jumping"
static var FALLING: StringName = "falling"
static var LANDING: StringName = "landing"
static var DASHING: StringName = "dashing"
static var ATTACKING: StringName = "attacking"
