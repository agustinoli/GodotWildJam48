extends Node

onready var audio = [$AudioStreamPlayer1, $AudioStreamPlayer2, $AudioStreamPlayer3,
	$AudioStreamPlayer4, $AudioStreamPlayer5, $AudioStreamPlayer6]

func _ready():
	initialize()
	pass

func get_player(val):
	return audio[val]

func initialize():
	set_music(load ("res://Assets/Music/MoonGameMusicPad1.ogg")  ,0)
	set_music(load ("res://Assets/Music/MoonGameMusicPad2.ogg")  ,1)
	set_music(load ("res://Assets/Music/MoonGameMusicPluck.ogg") ,2)
	set_music(load ("res://Assets/Music/MoonGameMusicMelody.ogg"),3)
	set_music(load ("res://Assets/Music/MoonGameMusicBass.ogg")  ,4)
	set_music(load ("res://Assets/Music/MoonGameMusicDrums.ogg") ,5)
	start_playing()
	set_volume(0,0)
	set_volume(1,0)
	


func start_playing():
	for i in range(audio.size()):
		audio[i].play()
	for i in range(audio.size()):
		set_volume(i,-2)


func set_music(music:Resource,val)->void:
	audio[val].stream = music


func set_volume(val,db)->void:
	audio[val].set_volume_db(db)
