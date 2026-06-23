extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var heldItem = null

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	if InventoryManager.inventory[PlayerManager.selectedSlot]["item"] !=  "":
		heldItem = InventoryManager.inventory[PlayerManager.selectedSlot]["file"]
	
		match heldItem.TYPE:
			"weapon":
				use_weapon(heldItem)

func use_weapon(_itemFile):
	if Input.is_action_just_pressed("l-click"):
		match PlayerManager.recentDirection:
			"left":
				animation_player.play("swing_left")
			"right":
				animation_player.play("swing_right")
			"up":
				animation_player.play("swing_up")
			"down":
				animation_player.play("swing_down")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		pass
