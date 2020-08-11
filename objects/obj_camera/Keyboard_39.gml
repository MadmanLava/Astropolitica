/// Move camera right
if(window_has_focus())
{
	#region Grab Camera Data
	var camerax = camera_get_view_x(camera);
	var cameray = camera_get_view_y(camera);
	
	var camerawidth = camera_get_view_width(camera);
	var modif = camerawidth / 100;
	
	#endregion
	
	if(keyboard_check(vk_right) and (camerax + (10 * panspeed)) < (room_width - camerawidth))
	{
		camera_set_view_pos(camera, (camerax + (10 * panspeed) + modif), cameray)
	}
}