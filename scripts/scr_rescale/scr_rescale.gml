/// scr_scale();
/// Rescales the game.

//Grab game window size
if(window_get_fullscreen())
{
	var windowWidth = display_get_width();
	var windowHeight = display_get_height();
}
else
{
	var windowWidth = window_get_width();
	var windowHeight = window_get_height();
}

//Calculate the aspect ratio
var aspect = windowHeight/windowWidth;

//Alter viewport
view_wport[0] = windowWidth;
view_hport[0] = windowHeight;

//Correct the application surface
surface_resize(application_surface, view_wport[0], view_hport[0]);

//Calculate the cam height from the current width and aspect ratio
var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camWidth * aspect;

camera_set_view_size(view_camera[0], camWidth, camHeight);

//Fix the UI
display_set_gui_maximize();