var surf = obj_systemManager.dataSurf;

surface_set_target(surf);
if(owner != pointer_null)
{
	draw_point_color(seq_x, seq_y, ownerColor);
}
else
{
	draw_point_color(seq_x, seq_y, c_white);
}
surface_reset_target();