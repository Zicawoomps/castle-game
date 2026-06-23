extends Node2D

@onready var damage_indicator: Node2D = $"."

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fall":
		damage_indicator.queue_free()
