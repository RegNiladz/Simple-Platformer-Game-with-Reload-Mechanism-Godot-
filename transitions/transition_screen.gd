extends CanvasLayer
signal transitioned


func _ready():
	transition()

func transition():
	$Transition_Animation.play("Fade_To_Black")



func _on_Transition_Screen_transitioned(anim_name):
	if anim_name == "Fade_To_Black":
		emit_signal("transitioned")
		print("Transitioned")
		$Transition_Animation.play("Fade_Transition")
	if anim_name == "Fade_Transition":
		print("finish fade")
