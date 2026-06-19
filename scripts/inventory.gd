extends Node

@onready var hot_bar: HBoxContainer = $Control/MarginContainer2/HotBar

var selectedSlot = 0

func changeSlotColor(slot):
	var slotTexture = hot_bar.get_child(slot).get_child(0)
	slotTexture.texture = load("res://assets/selected_slot.png")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		selectedSlot = 0
	elif Input.is_action_just_pressed("2"):
		selectedSlot = 1
	elif Input.is_action_just_pressed("3"):
		selectedSlot = 2
	elif Input.is_action_just_pressed("4"):
		selectedSlot = 3
	elif Input.is_action_just_pressed("5"):
		selectedSlot = 4
	
	match selectedSlot:
		0:
			changeSlotColor(0)
			hot_bar.get_child(1).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(2).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(3).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(4).get_child(0).texture = load("res://assets/inv_slot.png")
			
		1:
			changeSlotColor(1)
			hot_bar.get_child(0).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(2).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(3).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(4).get_child(0).texture = load("res://assets/inv_slot.png")
			
		2:
			changeSlotColor(2)
			hot_bar.get_child(1).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(0).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(3).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(4).get_child(0).texture = load("res://assets/inv_slot.png")
			
		3:
			changeSlotColor(3)
			hot_bar.get_child(1).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(2).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(0).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(4).get_child(0).texture = load("res://assets/inv_slot.png")
			
		4:
			changeSlotColor(4)
			hot_bar.get_child(1).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(2).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(3).get_child(0).texture = load("res://assets/inv_slot.png")
			hot_bar.get_child(0).get_child(0).texture = load("res://assets/inv_slot.png")
			
	
	for i in InventoryManager.inventory.size():
		var itemData = InventoryManager.inventory[i]
		var slot = hot_bar.get_child(i)
		var slotItem = slot.get_child(2)
		slot.get_child(1).get_child(0).hide()
		var itemTexture = load("res://assets/temp_empty_slot.png")
		if itemData["item"] == "":
			slotItem.texture = itemTexture
			continue
		itemTexture = load("res://assets/" + itemData["item"] + ".png")
		if itemData["count"] > 1:
			slot.get_child(1).get_child(0).show()
		slotItem.texture = itemTexture
		slot.get_child(1).get_child(0).text = str(itemData["count"])
