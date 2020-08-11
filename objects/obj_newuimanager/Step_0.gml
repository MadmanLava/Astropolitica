//hover = instance_nearest(mouse_x, mouse_y, obj_system);

var leftBound = 300;
var rightBound = (winW - leftBound);
if(!global.cleanupMode and mousex > leftBound and mousex < rightBound)
{
	hover = collision_circle(mouse_x, mouse_y, 9, obj_system, false, true);
	if(!hover)
	{
		hover = pointer_null;
	}
}
else
{
	hover = pointer_null;
}