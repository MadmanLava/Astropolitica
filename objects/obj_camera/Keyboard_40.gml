/// Move camera down
if(window_has_focus())
{
	#region Grab Camera Data
	var camerax = camera_get_view_x(camera);
	var cameray = camera_get_view_y(camera);
	
	var camerawidth = camera_get_view_width(camera);
	var cameraheight = camera_get_view_height(camera);
	var modif = camerawidth / 100;
	
	#endregion
	
	if(keyboard_check(vk_down) and (cameray + (10 * panspeed)) < (room_height - cameraheight))
	{
		camera_set_view_pos(camera, camerax, (cameray + (10 * panspeed) + modif))
	}
}