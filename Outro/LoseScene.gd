extends Node

var msgs = [	"LOS1",
				"LOS2",
				"LOS3"
			]
onready var msg_index = -1

var timer

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer.connect("timeout", self, "next_msg")
	timer.autostart = true
	add_child(timer)


func _input(event):
	if event.is_pressed():
		next_msg()


func next_msg():
	timer.stop()
	timer.start(10)
	if msg_index >= msgs.size() -1:
		Game.emit_signal("ChangeScene","res://Credits/Credits.tscn")
	else:
		msg_index += 1
		$Message.text = tr(msgs[msg_index])
