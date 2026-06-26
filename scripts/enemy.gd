extends CharacterBody2D

@onready var Enemy: CharacterBody2D = $"."
@export var File : Resource
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Health = File.Health
var load_di = preload("res://scenes/damage_indicator.tscn")
var heldItem = null

func _ready() -> void:
	animated_sprite.sprite_frames = File.SpriteSheet

func _process(_delta: float) -> void:
	heldItem = InventoryManager.inventory[PlayerManager.selectedSlot]["file"]


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var Damage = heldItem.WeaponDamage
		if Health - Damage >= 0:
			Health -= Damage
		elif Health > -100:
			Health = 0
		indicate_damage(Enemy)
		if Health == 0:
			Enemy.queue_free()
				
func indicate_damage(parent):
	var DamageIndicator = load_di.instantiate()
	parent.add_sibling(DamageIndicator)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rngX = rng.randi_range(-5,9)
	var rngY = rng.randi_range(-10,-18)
	DamageIndicator.position = Vector2(parent.position.x + rngX, parent.position.y + rngY)
	DamageIndicator.get_child(0).get_child(0).text = str(heldItem.WeaponDamage)
