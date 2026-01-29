extends Control

func _on_start_pressed():
	# Transition to the loading screen
	get_tree().change_scene_to_file("res://scenes/worlds/loading_screen.tscn")

func _on_quit_pressed():
	get_tree().quit()
