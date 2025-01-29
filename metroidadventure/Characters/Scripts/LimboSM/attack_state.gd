extends CharacterState

var timer: float = 0.0
var timer_attack: float = 0.25

func _enter():
	blue_player = agent as CharacterBody2D
	player_stats = blue_player.stats
	timer = timer_attack
	play_effects()

func _exit():
	blackboard.set_var(BBNames.attack_var, false)
	blue_player.snd_sword_attack.stop()

func _update(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		dispatch(StateReferences.STOPPED)

func play_effects():
	blue_player.animation_player.play(animation_name)
	blue_player.snd_sword_attack.pitch_scale = RandomNumberGenerator.new().randf_range(0.90, 1.0)
	prints(blue_player.snd_sword_attack.pitch_scale, blue_player.snd_sword_attack.volume_db)
	blue_player.snd_sword_attack.play()
