extends Control

var transitioning = false

func _ready():
	Global.connect("start", self, "_on_start")
	$AnimationPlayer.play("fade")

	if Global.autostart:
		Global.emit_signal("start")

func _on_animation_finished(_anim):
	pass

func _input(event):
	if transitioning:
		return

	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_SPACE and visible:
			yield(get_tree(), "idle_frame")
			Global.emit_signal("start")

		if event.scancode == KEY_ESCAPE:
			if visible:
				get_tree().quit()
			else:
				yield(get_tree(), "idle_frame")
				get_tree().change_scene("res://gym/Gym.tscn")

func _on_start():
	hide()
