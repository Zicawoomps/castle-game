extends Area2D

@export_file("*.tscn") var room : String

func _on_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file.call_deferred(room)
