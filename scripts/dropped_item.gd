extends Node2D
@onready var dropped_item: Node2D = $"."

const TOY_SWORD = preload("uid://cnnb485loeg3f")
var inv = InventoryManager.inventory

func _on_area_2d_body_entered(_body: Node2D) -> void:
	pickupItem(TOY_SWORD)

func pickupItem(itemId):
	var pickedUpItem := false
	for i in inv:
		if inv[i]["count"] < itemId.MaxStackSize and pickedUpItem == false:
			if inv[i]["item"] == "" or inv[i]["item"] == itemId.ItemName:
				inv[i]["item"] = itemId.ItemName
				inv[i]["count"] += 1
				pickedUpItem = true
				dropped_item.queue_free()
