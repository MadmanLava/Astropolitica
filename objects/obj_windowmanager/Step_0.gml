//Checks if the window has focus and if the window changes in size somehow before correcting the scaling.
if(winW != window_get_width() || winH != window_get_height())
{
	show_debug_message("Resizing!");
	
	scr_rescale();
	
	winW = window_get_width();
	winH = window_get_height();
	
}