extends Node2D
@onready var dropped_item: Node2D = $"."

@export var item = Resource

func _ready() -> void:
	dropped_item.get_child(0).texture = item.HeldItemTexture

var inv = InventoryManager.inventory

func _on_area_2d_body_entered(_body: Node2D) -> void:
	pickupItem(item)

func pickupItem(itemId):
	var pickedUpItem := false
	for i in inv:
		if inv[i]["count"] < itemId.MaxStackSize and pickedUpItem == false:
			if inv[i]["item"] == "" or inv[i]["item"] == itemId.ItemName:
				inv[i]["item"] = itemId.ItemName
				inv[i]["count"] += 1
				inv[i]["file"] = itemId
				pickedUpItem = true
				dropped_item.queue_free()
