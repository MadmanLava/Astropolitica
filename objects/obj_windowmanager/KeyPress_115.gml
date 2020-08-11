if(window_has_focus())
{
	if(!window_get_fullscreen())
	{
		window_set_fullscreen(true);
		
		scr_rescale();

	}
	else
	{
		window_set_fullscreen(false);
		
		scr_rescale();

	}
}