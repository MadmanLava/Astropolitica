/// Zoom in 
if(window_has_focus() and camera_get_view_width(camera) > CAM_MINIMUM_SCALE)
{
	var camerax = camera_get_view_x(camera);
	var cameray = camera_get_view_y(camera);

	var camerawidth = camera_get_view_width(camera);
	var cameraheight = camera_get_view_height(camera);
	
	var guiMouseX = window_mouse_get_x();
	var guiMouseY = window_mouse_get_y();
	
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
	
	if(guiMouseX > 300 and guiMouseX < winW - 300 and guiMouseY > 30)
	{
		var widthFactor = 16 * mousescrollspeed;
		var heightFactor = widthFactor * (winH/winW);
	
		//Recalculate the camera scroll factor
		global.camScroll = (camerawidth - (widthFactor)) / CAM_BASE_WIDTH
	
		camera_set_view_size(camera, (camerawidth - (widthFactor)), (cameraheight - (heightFactor)));
			
		//Scrolling compensation
		camera_set_view_pos(camera, camerax + (widthFactor/2), cameray + (heightFactor/2));
	}
}