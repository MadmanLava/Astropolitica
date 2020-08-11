/// @desc reset countdown

room_goto(mainmenu);
						
draw_texture_flush();
with(obj_mainmenu)
{
	menu = 1;
	ds_grid_clear(scroll, 0);
}