class_name Facing
extends Node2D

func face_proper_direction(char_vel: float) -> void:
	if char_vel > 0:
		scale.x = 1.0
	elif char_vel < 0:
		scale.x = -1.0
