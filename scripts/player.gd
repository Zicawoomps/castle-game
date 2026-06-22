extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var heldItem: Sprite2D = $HeldItem/Sprite2D


const SPEED = 60

func _ready() -> void:
	animated_sprite.play("idle_down")

func _physics_process(_delta: float) -> void:
	var DIRECTION = Input.get_vector("left", "right", "up", "down")
	velocity = DIRECTION * SPEED
	if velocity != Vector2.ZERO:
		if DIRECTION.x == -1:
			animated_sprite.play("walk_left")
			PlayerManager.recentDirection = "left"
		elif DIRECTION.x == 1:
			animated_sprite.play("walk_right")
			PlayerManager.recentDirection = "right"
		elif DIRECTION.y == -1:
			animated_sprite.play("walk_up")
			PlayerManager.recentDirection = "up"
		elif DIRECTION.y == 1:
			animated_sprite.play("walk_down")
			PlayerManager.recentDirection = "down"
	else:
		match PlayerManager.recentDirection:
			"left":
				animated_sprite.play("idle_left")
			"right":
				animated_sprite.play("idle_right")
			"up":
				animated_sprite.play("idle_up")
			"down":
				animated_sprite.play("idle_down")
	move_and_slide()

func _process(_delta: float) -> void:
	if InventoryManager.inventory[PlayerManager.selectedSlot]["item"] !=  "":
		heldItem.texture = InventoryManager.inventory[PlayerManager.selectedSlot]["file"].HeldItemTexture
	else:
		heldItem.texture = null
