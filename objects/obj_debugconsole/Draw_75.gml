if(consoleOpen)
{
	#region set draws
	if(draw_get_halign() != fa_left)
	{
		draw_set_halign(fa_left)
	}
	if(draw_get_valign() != fa_bottom)
	{
		draw_set_valign(fa_bottom);
	}
	if(draw_get_font() != fnt_debug)
	{
		draw_set_font(fnt_debug);
	}
	#endregion
	
	#region Draw Box
	draw_set_color(c_white);
	
	//Box
	draw_rectangle_color(0, 0, 400, 600, c_gray, c_gray, c_gray, c_gray, false);
	//Outline
	draw_rectangle_color(0, 0, 400, 600, c_gray, c_gray, c_gray, c_gray, true);
	//Bottom
	draw_rectangle_color(0, 580, 400, 600, c_gray, c_gray, c_gray, c_gray, false);
	draw_set_alpha(1);
	#endregion
	
	#region Text
	
	draw_text_ext(5, 600, inputHolder, 20, 390);
	//ticker
	if(typing)
	{
		var w = string_width(inputHolder);
		
		draw_line(7 + w, 585, 7 + w, 595);
	}
	
	//Results
	var i = ds_list_size(displayList) - 1;
	var py = 580;
	repeat(ds_list_size(displayList))
	{
		var entry = ds_list_find_value(displayList, i);
		
		py = py - string_height_ext(entry, -1, 390);
		
		draw_text_ext(5, py, entry, -1, 390);
		
		i = i - 1;
	}
	
	#endregion
}