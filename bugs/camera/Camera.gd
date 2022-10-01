extends Camera2D

func small_shake() -> void:
	$ScreenShake.start(0.1,10,7,0)

func medium_shake() -> void:
	$ScreenShake.start(0.2, 10, 10, 0)
