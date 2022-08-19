extends Area2D

var msgs = [	" - Terraform the moon -\nThis is a notebook with\nall the help you need\nfor accomplish your\npurpose. \nPress 'R' for reading the\nnext page.",
				"Key - Machine\n'1' - Power Machine\n'2' - Mineral Machine\n'3' - Water Machine\n'4' - Food Machine",
				"After placing a machine,\ngo near it and press 'E'\nfor finishing the\nbuilding process.\nEach machine gives you\nperiodical amounts of a\nresource.",
				"When building a machine,\nyou give it an amount of\nyour one electric charge.\nKeep an eye in your\ncharge or you will go\nshuted down.",
				"You may need to\nrecharge yourself. To\ndo this, just get close to\nyour space ship.",
				"Try to terraform\nthis ground by building\nfood machines!"
			]
onready var msg_index = 0

func _ready():
	$"ColorRect/ColorRect/Label".text = msgs[msg_index]

func swap_page():
	msg_index += 1
	if msg_index < msgs.size():
		$"ColorRect/ColorRect/Label".text = msgs[msg_index]
	else:
		msg_index = 0

func show():
	self.visible = not self.visible
	if not self.visible:
		msg_index = 0
		$"ColorRect/ColorRect/Label".text = msgs[msg_index]
