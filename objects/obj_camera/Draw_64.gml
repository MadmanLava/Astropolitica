/// @desc Camera input and regulation.

if(window_has_focus())
{
	#region Grab Data
	var camerax = camera_get_view_x(camera);
	var cameray = camera_get_view_y(camera);
	
	var guiMouseX = window_mouse_get_x();
	var guiMouseY = window_mouse_get_y();
	
	//var camerawidth = camera_get_view_width(camera);
	//var cameraheight = camera_get_view_height(camera);

	if(window_get_fullscreen())
	{
		var winW = display_get_width();
		var winH = display_get_height();
	}
	else
	{
		var winW = window_get_width();
		var winH = window_get_height();
	}
	
	#endregion
	
	#region Mouse Panning
	if(mouse_check_button(mb_middle) and (guiMouseX > 300 and guiMouseX < winW - 300) and guiMouseY > 30)
	{
		panning = true;
		var mousediffx = mouseholderx - window_view_mouse_get_x(0);
		var mousediffy = mouseholdery - window_view_mouse_get_y(0);
	
		camera_set_view_pos(camera, camerax + mousediffx, cameray + mousediffy);
		camerax = camera_get_view_x(camera);
		cameray = camera_get_view_y(camera);
	}
	else
	{
		panning = false;
		mouseholderx = window_view_mouse_get_x(0);
		mouseholdery = window_view_mouse_get_y(0);
	}
	#endregion
	
}