extends Area2D

var msgs = [	"             - Notebook -\nThis is a notebook with all the\nhelp you need to accomplish your\nsacred purpose. \n\nPress 'R' to read the next page,\nor press 'N' to show/hide this\nnotebook.\n\n                                     Page 1/9",
				"              - Target - \nTerraform this ground by building\nmachines. Each machine have a\ncost: you need to spend your\nown resources, although each\nmachine gives you periodical\namounts of them.\nKeep an eye on how you spend\nyour resources!\n                                     Page 2/9",
				"        - Building Machines -\nChoose the machine you want to\nbuild by pressing the correct\nkey (in next pages). Then,\nplace the machine where you\nwant to. To finish the building\nprocess, go near your new machine\nand press 'E'.\n\n                                     Page 3/9",
				"====> Power Machine\n=> Requires\n  30 units of mineral\n=> Produces\n  1 unit per sec of power\n=> Build key\n  '1'\n\n\n                                     Page 4/9",
				"====> Mineral Machine\n=> Requires\n  20 units of mineral\n  1 unit per sec of power\n=> Produces\n  1 unit per sec of mineral\n=> Build key\n  '2'\n\n                                     Page 5/9",
				"====> Water Machine\n=> Requires\n  50 units of mineral\n  5 unit per sec of power\n  1 unit per sec of mineral\n=> Produces\n  1 unit per sec of water\n=> Build key\n  '3'\n                                     Page 6/9",
				"====> Food Machine\n=> Requires\n  50 units of mineral\n  30 units of water\n  1 unit per sec of power\n=> Produces\n  1 unit per sec of food\n=> Build key\n  '4'\n                                     Page 7/9",
				"        - Charge yourself -\nWhen building a machine, you give\nit an amount of your one electric\ncharge. Keep an eye in your\ncharge or you will go shuted down.\nYou may need to recharge\nyourself. To do this, just get\nclose to your space ship.\n\n                                     Page 8/9",
				"           - Resources -\nYour resources, as well as your\ncharge, are being displayed in\nthe top section of the screen.\n\n\n\n\n\n                                     Page 9/9",
				"\n\n\n\n\n\n\n\n\n             - Notebook -"
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
