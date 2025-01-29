extends CharacterState

@export var attack_2: StringName
@export var attack_3: StringName

var timer: float = 0.0
var timer_attack: float = 0.25

func _enter():
	blue_player = agent as CharacterBody2D
	player_stats = blue_player.stats
	timer = timer_attack
	play_effects()
	blue_player.animation_player.animation_finished.connect(_on_animation_finished)

func _exit():
	_reset_attack()
	blue_player.snd_sword_attack.stop()
	blue_player.animation_player.animation_finished.disconnect(_on_animation_finished)

func play_effects(anim_name: StringName = animation_name):
	blue_player.animation_player.play(anim_name)
	blue_player.snd_sword_attack.pitch_scale = RandomNumberGenerator.new().randf_range(0.90, 1.0)
	prints(blue_player.snd_sword_attack.pitch_scale, blue_player.snd_sword_attack.volume_db)
	blue_player.snd_sword_attack.play()
	_reset_attack()

func _on_animation_finished(p_animation: StringName) -> void:
	if not has_player_attacked():
		dispatch(StateReferences.STOPPED)
		return

	match p_animation:
		animation_name:
			play_effects(attack_2)
		attack_2:
			play_effects(attack_3)
		_:
			dispatch(StateReferences.STOPPED)


func _reset_attack() -> void:
	blackboard.set_var(BBNames.attack_var, false)
