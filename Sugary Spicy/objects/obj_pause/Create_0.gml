instance_deactivate_all(true)
menu = [
	"Continue",
	"Retry",
	"Exit to Hub",
	"Options"
]

select = 0
selmax = 3

audio_pause_all()
audio_resume_sound(mu_pause)
audio_sound_gain(mu_pause,1,0)
bgx = 0
bgy = 0
