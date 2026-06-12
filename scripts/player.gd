extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

const SPEED = 70

func _ready() -> void:
	animated_sprite.play("walk up")

func _physics_process(_delta: float) -> void:
	var DIRECTION = Input.get_vector("left", "right", "up", "down")
	velocity = DIRECTION * SPEED
	
	if DIRECTION.x == -1:
		animated_sprite.play("walk left")
		collision_shape.rotation = 90
	elif DIRECTION.x == 1:
		animated_sprite.play("walk right")
		collision_shape.rotation = 90
	elif DIRECTION.y == -1:
		animated_sprite.play("walk up")
		collision_shape.rotation = 0
	elif DIRECTION.y == 1:
		animated_sprite.play("walk down")
		collision_shape.rotation = 0
	move_and_slide()
