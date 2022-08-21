extends Node

var msgs = [	"TUTORIAL1",
				"TUTORIAL2",
				"TUTORIAL3",
				"TUTORIAL4",
				"TUTORIAL5",
				"TUTORIAL6",
				"TUTORIAL7",
				"TUTORIAL8",
				"TUTORIAL9"
			]
onready var msg_index = -1

var timer

func _ready():
	$Camera2D._set_current(true)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer.connect("timeout", self, "next_msg")
	timer.autostart = true
	add_child(timer)
	SfxManager.play("moon")


func _input(event):
	if event.is_pressed():
		next_msg()


func next_msg():
	timer.stop()
	timer.start(10)
	if msg_index >= msgs.size() -1:
		Game.emit_signal("ChangeScene","res://Levels/TestScene.tscn")
	else:
		msg_index += 1
		$Message.text = tr(msgs[msg_index])
