if(global.drawCountryNames)
{
	#region set draws
	if(draw_get_valign() != fa_middle)
	{
		draw_set_valign(fa_middle);
	}
	if(draw_get_halign() != fa_middle)
	{
		draw_set_halign(fa_center);
	}
	if(draw_get_font() != fnt_default)
	{
		draw_set_font(fnt_default);
	}
	#endregion
	
	//var scale = averageRadius/string_width(name);
	/*var scale = (averageRadius/baseWidth);

	if(scale < 1)
	{
		scale = 1;
	}
	if(scale > 5)
	{
		scale = 5;
	}*/
	var scale = (global.camWid/window_get_width())

	draw_text_transformed_color(averageCenterX, averageCenterY, baseName, scale, scale, 0, color1, color1, c_white, c_white, 1);
}