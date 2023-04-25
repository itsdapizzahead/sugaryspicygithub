audio_resume_all()
audio_stop_sound(mu_pause)
audio_sound_gain(mu_pause,0,0)
instance_destroy(obj_options)
if (instance_number(obj_pause) > 1)
{
	instance_destroy(obj_pause)
	exit;
}
instance_activate_all()