extends Node

@onready var door_1_collision: Area2D = $door1Collision
@onready var door_2_collision: Area2D = $door2Collision
@onready var door_3_collision: Area2D = $door3Collision
@onready var player: CharacterBody2D = $"../CharacterBody2D"


func _process(_delta: float) -> void:
	if Input.is_action_pressed("z"):
		if door_1_collision.overlaps_body(player):
			get_tree().change_scene_to_file("res://scenes/room_one.tscn")
		elif door_2_collision.overlaps_body(player):
			get_tree().change_scene_to_file("res://scenes/room_two.tscn")
		elif door_3_collision.overlaps_body(player):
			get_tree().change_scene_to_file("res://scenes/room_three.tscn")
