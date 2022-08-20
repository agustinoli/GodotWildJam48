extends Area2D

var msgs = [	"NOTEBOOK1",
				"NOTEBOOK2",
				"NOTEBOOK3",
				"NOTEBOOK4",
				"NOTEBOOK5",
				"NOTEBOOK6",
				"NOTEBOOK7",
				"NOTEBOOK8",
				"NOTEBOOK9",
				"NOTEBOOK10"
			]
onready var msg_index = 0

func _ready():
	$"ColorRect/ColorRect/Label".text = msgs[msg_index]


func _process(_delta):
	if Input.is_action_just_pressed("SwapNotebookPage") and self.visible:
		swap_page()


func swap_page():
	if self.visible:
		msg_index += 1
		if msg_index >= msgs.size():
			msg_index = 0
		$"ColorRect/ColorRect/Label".text = msgs[msg_index]

func show():
	self.visible = not self.visible
	if not self.visible:
		msg_index = 0
		$"ColorRect/ColorRect/Label".text = msgs[msg_index]
