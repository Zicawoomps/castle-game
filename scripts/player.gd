extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var heldItemScene = preload("res://scenes/held_item.tscn")
var heldItem = heldItemScene.instantiate()

var holdingItem = false

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
	PlayerManager.player_position = global_position
	if InventoryManager.inventory[PlayerManager.selectedSlot]["item"] !=  "":
		heldItem.get_child(1).texture = InventoryManager.inventory[PlayerManager.selectedSlot]["file"].HeldItemTexture
		if !holdingItem:
			add_child(heldItem)
			holdingItem = true
	elif holdingItem:
		remove_child(heldItem)
		holdingItem = false
	if PlayerManager.HEALTH <= 0:
		OS.set_restart_on_exit(true)
		get_tree().quit()
