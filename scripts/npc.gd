extends StaticBody2D

@export var npc_id: String

func interact():
	print("Interacting with NPC: ", npc_id)
	DialogueManager.start_dialogue(npc_id)
