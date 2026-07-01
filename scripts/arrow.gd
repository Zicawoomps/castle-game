extends Sprite2D

var direction := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = (PlayerManager.player_position - global_position).normalized()
	rotation = direction.angle()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * 60 * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		PlayerManager.HEALTH -= 5
		queue_free()
