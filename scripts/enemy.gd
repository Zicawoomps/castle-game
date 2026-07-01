extends CharacterBody2D

@onready var Enemy: CharacterBody2D = $"."
@export var File : Resource
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var Health = File.Health
var load_di = preload("res://scenes/damage_indicator.tscn")
var heldItem = null
var chasingPlayer = false
var player = null
var load_item = preload("res://scenes/dropped_item.tscn")
var rng = RandomNumberGenerator.new()
@onready var Speed = Enemy.File.Speed
var load_cell = preload("res://scenes/nav_cell.tscn")
@onready var enemy_weapon: Sprite2D = $EnemyWeapon
var load_arrow = preload("res://scenes/arrow.tscn")

func _ready() -> void:
	animated_sprite.sprite_frames = File.SpriteSheet
	get_child(5).texture = File.Weapon

func _process(_delta: float) -> void:
	heldItem = InventoryManager.inventory[PlayerManager.selectedSlot]["file"]
	if player != null:
		enemy_weapon.look_at(player.global_position)
		
func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		chasingPlayer = true
		player = body

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		chasingPlayer = false
		player = null

func _physics_process(_delta: float) -> void:
	move_and_slide()
		
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		var Damage = heldItem.WeaponDamage
		if Health - Damage >= 0:
			Health -= Damage
		elif Health > -100:
			Health = 0
		indicate_damage(Enemy)
		if Health == 0:
			destroy(Enemy)
			
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

func path_finding():
	if Speed > 0 and chasingPlayer:
		move()
	else:
		velocity = Vector2.ZERO
	
func move():
	var nav_cell = load_cell.instantiate()
	var rngX = rng.randi_range(-20,20)
	var rngY = rng.randi_range(-20,20)
	nav_cell.connect("touch", _on_timer_timeout)
	add_sibling(nav_cell)
	nav_cell.position = Vector2(player.global_position.x + rngX, player.global_position.y + rngY)
	var direction : Vector2 = (nav_cell.global_position - Enemy.global_position).normalized()
	velocity = direction * Speed

func shoot_arrow():
	if enemy_weapon.texture != null:
		var arrow = load_arrow.instantiate()
		arrow.global_position = global_position
		add_sibling(arrow)


func _on_timer_timeout() -> void:
	path_finding()
	shoot_arrow()
