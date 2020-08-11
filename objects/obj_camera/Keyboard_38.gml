/// Move camera up
if(window_has_focus())
{
	#region Grab Camera Data
	var camerax = camera_get_view_x(camera);
	var cameray = camera_get_view_y(camera);
	
	var camerawidth = camera_get_view_width(camera);
	var modif = camerawidth / 100;
	
	#endregion
	
	if(keyboard_check(vk_up) and (cameray - (10 * panspeed)) > 0)
	{
		camera_set_view_pos(camera, camerax, (cameray - (10 * panspeed) - modif))
	}
}