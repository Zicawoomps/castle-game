extends Area2D

signal touch

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Actual_Enemy"):
		touch.emit()
		queue_free()
