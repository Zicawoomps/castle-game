extends Node2D

@onready var gatherable_resource: StaticBody2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var File : Resource
@onready var Health = File.Health
var load_di = preload("res://scenes/damage_indicator.tscn")
var load_item = preload("res://scenes/dropped_item.tscn")
var rng = RandomNumberGenerator.new()
var heldItem = null

func _ready() -> void:
	sprite_2d.texture = File.ResourceTexture
	
func _process(_delta: float) -> void:
		heldItem = InventoryManager.inventory[PlayerManager.selectedSlot]["file"]


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var Damage = heldItem.WeaponDamage
		if Health - Damage >= 0:
			Health -= Damage
		elif Health > -100:
			Health = 0
		indicate_damage(gatherable_resource)
		if Health == 0:
			destroy(gatherable_resource)				
func indicate_damage(parent):
	var DamageIndicator = load_di.instantiate()
	parent.add_sibling(DamageIndicator)
	rng.randomize()
	var rngX = rng.randi_range(-5,9)
	var rngY = rng.randi_range(-10,-18)
	DamageIndicator.position = Vector2(parent.position.x + rngX, parent.position.y + rngY)
	DamageIndicator.get_child(0).get_child(0).text = str(heldItem.WeaponDamage)

func destroy(parent):
	rng.randomize()
	var rngX = rng.randi_range(-6,6)
	var rngY = rng.randi_range(-4,4)
	var DroppedItem = load_item.instantiate()
	parent.call_deferred("add_sibling", DroppedItem)
	DroppedItem.item = parent.File.ItemDrops
	DroppedItem.position = Vector2(parent.position.x + rngX, parent.position.y + rngY)
	parent.queue_free()
