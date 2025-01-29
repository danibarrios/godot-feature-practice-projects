extends State

@export var fall_state: State
@export var idle_state: State

const dash_speed: float = 500.0
const dash_timer: float = 0.3
const collission_right_mov_pos = 6
const collission_left_mov_pos = -6
const collission_right_mov_rot = 41.5
const collission_left_mov_rot = -41.5

var timer: float = 0

func enter() -> void:
	super()
	timer = dash_timer
	parent.velocity.x = dash_speed * get_x_movement_orientation()
	parent.velocity.y = 0
	parent.set_dash(true)
	handle_collision_position()	
	
	
func exit() -> void:
	parent.collisions_dictionary.get("dash_collision").disabled = true

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	timer -= delta
	if timer < 0:
		if !parent.is_on_floor():
			return fall_state
		else:
			return idle_state
			
	parent.move_and_slide()
	return null

func get_state_name() -> String:
	return state_name

func handle_collision_position() -> void:
	var collision: CollisionShape2D = parent.collisions_dictionary.get("dash_collision")
	collision.disabled = false
	
	if parent.velocity.x < 0 :
		collision.position.x = collission_left_mov_pos
		collision.rotation = collission_left_mov_rot
	else:
		collision.position.x = collission_right_mov_pos
		collision.rotation = collission_right_mov_rot
	
	var collision2: CollisionShape2D = parent.collisions_dictionary.get("main_collision")
	if collision2:
		collision2.disabled = true
