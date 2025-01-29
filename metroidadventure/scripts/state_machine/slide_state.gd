extends State #SlideState

@export var move_state: State
@export var jump_state: State
@export var fall_state: State

const collission_right_mov_pos = -14
const collission_left_mov_pos = 14
const collission_right_mov_rot = -48
const collission_left_mov_rot = 48
const slide_time = 0.5
const slide_speed = 350

var timer: float = 0


func enter() -> void:
	super()
	handle_collision_position()	
	timer = slide_time
	
	
func exit() -> void:
	super()
	var collision: CollisionShape2D = parent.collisions_dictionary.get("slide_collision")
	if collision:
		collision.disabled = true

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed(PlayerActions.JUMP):
		return jump_state
	return null
	
func process_physics(delta: float) -> State:
	parent.velocity.y += parent.gravity * delta
	timer -= delta
	if timer < 0:
		if !parent.is_on_floor():
			return fall_state
		else:
			return move_state
			
	parent.move_and_slide()
	return null
	
func handle_collision_position() -> void:
	var collision: CollisionShape2D = parent.collisions_dictionary.get("slide_collision")
	if collision:
		collision.disabled = false
		if parent.velocity.x < 0 :
			collision.position.x = collission_left_mov_pos
			collision.rotation = collission_left_mov_rot
			parent.velocity.x = -slide_speed
		else:
			collision.position.x = collission_right_mov_pos
			collision.rotation = collission_right_mov_rot
			parent.velocity.x = slide_speed
			
	var collision2: CollisionShape2D = parent.collisions_dictionary.get("main_collision")
	if collision2:
		collision2.disabled = true
		
func get_state_name() -> String:
	return state_name
