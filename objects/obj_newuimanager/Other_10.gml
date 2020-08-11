/// @desc Reset the event queue

#region Set draw
if(draw_get_halign() != fa_left)
{
	draw_set_halign(fa_left);
}
if(draw_get_valign() != fa_top)
{
	draw_set_valign(fa_top);
}
if(draw_get_color() != c_white)
{
	draw_set_color(c_white);
}
if(draw_get_font() != fnt_defaultverysmall)
{
	draw_set_font(fnt_defaultverysmall);
}
#endregion
	
surface_set_target(evSurface)
scr_nine_slice(spr_basicBox_9slice, 0, 0, 300, 200, true, c_white);
	
#region Draw events
var boxHeight = string_height("M") + 10;
var evHeight = boxHeight + 5 + evScroll;
	
var i = ds_grid_height(evQueue)-1;
repeat(ds_grid_height(evQueue))
{
	var entry = evQueue[# 0, i];
	var entryColor = evQueue[# 1, i];
	var hei = string_height_ext(entry, -1, 290);
		
	if(evHeight > (-1*boxHeight) and evHeight < 200)
	{
		draw_text_ext_color(5, evHeight, entry, -1, 290, entryColor, entryColor, entryColor, entryColor, 1);
	}
		
	evHeight += hei;
	i--;
}
	
#endregion
	
//Header
draw_set_valign(fa_middle);
scr_datumbox(0, 0, 300, boxHeight, true, c_white, "EVENTS", 300, 1, spr_basicBoxHeader_9slice)
	
surface_reset_target();