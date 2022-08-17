extends Node

var msgs = [	"Hi! You are <ROBOT NAME> and\nyou are on the Moon.",
				"Some crazy shit is happening\non Earth, you know?",
				"You've been brought here with an objective.",
				"We count our salvation on you, metallic friend.",
				"Just terraform the Moon.\nEasy peasy.",
				"Everything you need to know is in your notebook.\nPress <NOTEBOOK_KEY> for reading it.",
				"...",
				"Anyway, do it ASAP.",
				"Bye-bye, butterfly!"
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
	SfxManager.play("moon")


func _input(event):
	if event is InputEventKey and event.pressed:
		next_msg()


func next_msg():
	timer.stop()
	timer.start(10)
	if msg_index >= msgs.size() -1:
		Game.emit_signal("ChangeScene","res://Levels/TestScene.tscn")
	else:
		msg_index += 1
		$Message.text = tr(msgs[msg_index])
