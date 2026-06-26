extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var load_di = preload("res://scenes/damage_indicator.tscn")

var heldItem = null

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	if InventoryManager.inventory[PlayerManager.selectedSlot]["item"] !=  "":
		heldItem = InventoryManager.inventory[PlayerManager.selectedSlot]["file"]
	
		if heldItem is WeaponData:
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
#
#func _on_area_2d_area_entered(area: Area2D) -> void:
	#var Target = area.get_parent()
	#if area.is_in_group("Enemy"):
		#var Damage = heldItem.WeaponDamage
		#if Target.Health - Damage >= 0:
			#Target.Health -= Damage
		#elif Target.Health > -100:
			#Target.Health = 0
		#indicate_damage(Target)
		#print(Target.Health)
		#if Target.Health == 0:
			#Target.queue_free()
				#
#func indicate_damage(parent):
	#var DamageIndicator = load_di.instantiate()
	#parent.add_sibling(DamageIndicator)
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#var rngX = rng.randi_range(-5,9)
	#var rngY = rng.randi_range(-10,-18)
	#DamageIndicator.position = Vector2(parent.position.x + rngX, parent.position.y + rngY)
	#DamageIndicator.get_child(0).get_child(0).text = str(heldItem.WeaponDamage)
