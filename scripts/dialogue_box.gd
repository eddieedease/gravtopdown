extends CanvasLayer

@onready var label = $Panel/Label

func set_text(text: String):
	if label:
		label.text = text
